# variables.tf

variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "ap-northeast-2"  # 서울 리전 코드
}

variable "azs" {
  description = "The availability zones to use for the VPC"
  type        = list(string)
  default     = ["ap-northeast-2a", "ap-northeast-2b"]  # 서울 리전의 가용 영역
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t2.micro"
}