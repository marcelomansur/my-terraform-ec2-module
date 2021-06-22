locals {
  my_public_subnet_array = keys(aws_subnet.my_public_subnet)
}

# Internet gateway
resource "aws_internet_gateway" "my_internet_gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name   = "my_internet_gateway"
    Deploy = "Terraform"
  }
}

# NAT gateway
resource "aws_nat_gateway" "my_nat_gw" {
  allocation_id = aws_eip.my_eip.id
  subnet_id     = aws_subnet.my_public_subnet[local.my_public_subnet_array[0]].id

  tags = {
    Name   = "my_nat_gateway"
    Deploy = "Terraform"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.my_internet_gw]
}

# Elastic IP for NAT gateway
resource "aws_eip" "my_eip" {
  vpc = true

  tags = {
    "Name" = "my_elastic_nat_ip"
    Deploy = "Terraform"
  }
}
