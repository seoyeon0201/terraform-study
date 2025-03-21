provider "aws" {
    profile = "stocks_sy"
    region = "${var.region}" 
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
}
data "aws_availability_zones" "azs" {
  state = "available"
}