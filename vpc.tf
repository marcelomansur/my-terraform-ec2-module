resource "aws_vpc" "my_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name   = var.vpc_name
    Deploy = "Terraform"
  }
}
