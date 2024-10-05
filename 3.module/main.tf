# main.tf

# 모듈 호출 - VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"  # VPC 모듈
  version = "5.13.0" 

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = var.azs
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway = true
}

# 모듈 호출 - Security Group
module "security_group" {
  source = "terraform-aws-modules/security-group/aws"  # Security Group 모듈
  version = "5.0.0"

  name        = "my-security-group"
  description = "Allow SSH and HTTP"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
      {
        from_port   = 443                                #인바운드 시작 포트
        to_port     = 443                                #인바운드 끝나는 포트
        protocol    = "tcp"                              #사용할 프로토콜
        description = "https"                            #설명
        cidr_blocks = "0.0.0.0/0"                        #허용할 IP 범위
      },
      {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        description = "http"
        cidr_blocks = "0.0.0.0/0"
      },
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        description = "ssh"
        cidr_blocks = "0.0.0.0/0"
      }
  ]
    egress_with_cidr_blocks = [
      {
        from_port   = 0                                #아웃바운드 시작 포트
        to_port     = 0                                #아웃바운드 끝나는 포트
        protocol    = "-1"                             #사용할 프로토콜
        description = "all"                            #설명
        cidr_blocks = "0.0.0.0/0"                      #허용할 IP 범위
      }
  ]
}

# EC2 인스턴스 생성
resource "aws_instance" "my_ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.security_group.security_group_id]

  tags = {
    Name = "MyEC2Instance"
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