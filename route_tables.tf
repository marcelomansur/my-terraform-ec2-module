# Internet route table
resource "aws_route_table" "intenet_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_internet_gw.id
  }

  tags = {
    Name   = "intenet_route_table"
    Deploy = "Terraform"
  }
}

resource "aws_route_table_association" "intenet_association" {
  for_each = aws_subnet.my_public_subnet

  subnet_id      = each.value.id
  route_table_id = aws_route_table.intenet_route_table.id
}

# NAT route table
resource "aws_route_table" "nat_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_nat_gw.id
  }

  tags = {
    Name   = "nat_route_table"
    Deploy = "Terraform"
  }
}

resource "aws_route_table_association" "nat_association" {
  for_each = aws_subnet.my_private_with_nat_subnet

  subnet_id      = each.value.id
  route_table_id = aws_route_table.nat_route_table.id
}

# private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route = []

  tags = {
    Name   = "private_route_table"
    Deploy = "Terraform"
  }
}

resource "aws_route_table_association" "private_association" {
  for_each = aws_subnet.my_private_subnet

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_route_table.id
}
