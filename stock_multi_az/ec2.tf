# EC2 Security Group 생성
resource "aws_security_group" "ec2_security_group" {
  name        = "ec2-security-group"
  description = "Allow SSH, HTTP, and HTTPS access from local IP"
  vpc_id      = var.vpc_id

  # Inbound rules (Allow access from local IP)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
    description = "Allow SSH from all IPs"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # 모든 IP에서 HTTP 접근 허용
    description = "Allow HTTP from all"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # 모든 IP에서 HTTPS 접근 허용
    description = "Allow HTTPS from all"
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
    Name = "HA-test-EC2-Security-Group"
  }
}



# EC2 인스턴스 생성
resource "aws_instance" "my_ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]

  tags = {
    Name = "HA-test-EC2-Instance"
  }

  associate_public_ip_address = true
  
  # user_data 스크립트를 사용하여 EC2내에서 Nginx 설치 및 시작
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install nginx -y
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF
} 