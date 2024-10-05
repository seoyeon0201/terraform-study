terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

resource "aws_instance" "app_server" {
  ami           = "ami-05d2438ca66594916" #ubuntu
  instance_type = "t2.micro"

  tags = {
    Name = var.instance_name
  }
}
