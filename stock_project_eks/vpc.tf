# AWS region 내에서 사용 가능한 AZ 목록을 동적으로 가져옴
data "aws_availability_zones" "available" {}
locals {
  cluster_name = "sy-EKS-Cluster"
}

module vpc {
    source = "terraform-aws-modules/vpc/aws"
    version = "5.19.0"
    name = "sy-VPC"

    cidr = "10.20.0.0/16"
    azs = data.aws_availability_zones.available.names
    private_subnets = ["10.20.1.0/24", "10.20.2.0/24", "10.20.3.0/24"]
    public_subnets =  ["10.20.4.0/24", "10.20.5.0/24", "10.20.6.0/24"]
    enable_nat_gateway = true
    single_nat_gateway = true
    enable_dns_hostnames = true

    tags = {
        "Name" = "sy-VPC"
    }
    public_subnet_tags = {
        "Name" = "sy-Public-Subnet"
    }
    private_subnet_tags = {
        "Name" = "sy-Private-Subnet"
    }
}