resource "aws_db_subnet_group" "default" {
  name        = "sy-db-subnet-group"
  subnet_ids  = module.vpc.private_subnets
  description = "My DB Subnet Group"
}

resource "aws_db_instance" "default" {
    allocated_storage    = 10
    db_name              = "sydb"
    engine               = "mysql"
    engine_version       = "8.0"
    instance_class       = "db.t3.micro"
    username             = var.rds_username
    password             = var.rds_password
    parameter_group_name = "default.mysql8.0"
    skip_final_snapshot  = true

    db_subnet_group_name = aws_db_subnet_group.default.name
}