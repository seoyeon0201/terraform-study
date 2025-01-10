# Test용 프리티어 RDS

# RDS 보안 그룹 생성
resource "aws_security_group" "rds_security_group" {
  name        = "rds-security-group"
  description = "Allow MySQL access from EC2 instances"
  vpc_id      = var.vpc_id

  # Inbound rules (Allow MySQL access from EC2 Security Group)
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.ec2_security_group.id]  # EC2 Security Group에서만 접근 허용
    description = "Allow MySQL access from EC2"
  }

  # Outbound rules (Allow all traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "HA-test-RDS-SG"
  }
}

# RDS MySQL 인스턴스 생성 (MultiAZ)
resource "aws_db_instance" "my_mysql_rds" {
  identifier        = "my-mysql-rds"
  engine            = "mysql"
  engine_version    = "8.0"  
  instance_class    = "db.m6g.large"    # instance 스펙 변경
  allocated_storage = 20  
  storage_type      = "gp3"            # storage 스펙 변경
  db_name           = "stockdatabase"  # 기본 DB 이름
  username          = "admin" 
  password          = "adminpassword!" 
  multi_az          = true             # multi az 허용
  publicly_accessible = false
  vpc_security_group_ids = [aws_security_group.rds_security_group.id]
  db_subnet_group_name = aws_db_subnet_group.my_subnet_group.name
  backup_retention_period = 7  # 백업 보존 기간 설정

  tags = {
    Name = "HA-test-Multi-Az-MySQL-RDS-Instance"
  }

  final_snapshot_identifier = "my-rds-snapshot"
  skip_final_snapshot       = false
}

# DB Subnet Group (RDS가 배치될 서브넷 그룹)
resource "aws_db_subnet_group" "my_subnet_group" {
  name       = "my-subnet-group"
  subnet_ids = ["subnet-0a997c665b1d66c6b", "subnet-024898abd4f281f3b", "subnet-0b3b25a9837cc61cf"]

  tags = {
    Name = "HA-test-RDS-Subnet-Group"
  }
}

output "rds_endpoint" {
  value = aws_db_instance.my_mysql_rds.endpoint
}