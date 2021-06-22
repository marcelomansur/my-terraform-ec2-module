# Public subnet
resource "aws_subnet" "my_public_subnet" {
  for_each = toset(var.public_subnets)

  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = each.key

  tags = {
    Name   = "my_public_subnet_${each.key}"
    Deploy = "Terraform"
  }
}

# Private subnet
resource "aws_subnet" "my_private_subnet" {
  for_each = toset(var.private_subnets)

  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = each.key

  tags = {
    Name   = "my_private_subnet_${each.key}"
    Deploy = "Terraform"
  }
}

# Intra subnet
resource "aws_subnet" "my_intra_subnet" {
  for_each = toset(var.intra_subnets)

  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = each.key

  tags = {
    Name   = "my_intra_subnet_${each.key}"
    Deploy = "Terraform"
  }
}
