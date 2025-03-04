# outputs.tf

# EC2 인스턴스 이름 출력
output "ec2_instance_name" {
  description = "The name of the EC2 instance"
  value       = aws_instance.my_ec2_instance.tags["Name"]
}

# VPC ID 출력
output "vpc_id" {
  description = "The VPC ID"
  value       = var.vpc_id
}

# Public Subnet ID 출력
output "public_subnet_id" {
  description = "The public subnet ID"
  value       = var.public_subnet_id
}

# Security Group ID 출력
output "security_group_id" {
  description = "The security group ID"
  value       = aws_security_group.ec2_security_group.id
}

# RDS 인스턴스 ID 출력
output "rds_instance_id" {
  description = "The ID of the RDS instance"
  value       = aws_db_instance.my_mysql_rds.id
}

# RDS Security Group ID 출력
output "rds_security_group_id" {
  description = "The ID of the RDS Security Group"
  value       = aws_security_group.rds_security_group.id
}

# RDS DB Subnet Group 이름 출력
output "db_subnet_group_name" {
  description = "The name of the DB Subnet Group"
  value       = aws_db_subnet_group.my_subnet_group.name
}