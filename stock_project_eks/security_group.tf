# EKS에서 RDS 허용
resource "aws_security_group" "eks_node_sg" {
  name        = "eks-node-sg"
  description = "Security group for EKS nodes"

  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # 특정 IP 또는 Security Group에 접근 허용
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # 모든 프로토콜
    cidr_blocks = ["0.0.0.0/0"]  # 모든 IP에 대한 아웃바운드 허용
  }

  tags = {
    Name = "eks-node-sg"
  }
}

# RDS에서 EKS 허용
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Security group for RDS instance"
  vpc_id      = module.vpc.vpc_id

  # RDS에서 EKS 노드의 Security Group을 허용하도록 Inbound 규칙을 설정
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.eks_node_sg.id]  # EKS 노드의 Security Group 허용
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # 모든 프로토콜
    cidr_blocks = ["0.0.0.0/0"]  # 모든 IP에 대한 아웃바운드 허용
  }

  tags = {
    Name = "rds-sg"
  }
}