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

# Private_with_nat subnet
resource "aws_subnet" "my_private_with_nat_subnet" {
  for_each = toset(var.private_with_nat_subnets)

  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = each.key

  tags = {
    Name   = "my_private_with_nat_subnet_${each.key}"
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
