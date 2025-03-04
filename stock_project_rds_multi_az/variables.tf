# variables.tf

variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "ap-northeast-2"  # 서울 리전 코드
}

variable "azs" {
  description = "The availability zones to use for the VPC"
  type        = list(string)
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
}

variable "instance_type" {
  description = "The EC2 instance type"
  default     = "t2.micro"
}

variable "vpc_id" {
  description = "ID of the existing VPC"
}

variable "public_subnet_id" {
  description = "ID of the public subnet for the EC2 instance"
}
