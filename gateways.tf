resource "aws_internet_gateway" "my_internet_gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my_internet_gateway"
  }
}

resource "aws_nat_gateway" "my_nat_gw" {
  for_each = aws_subnet.my_private_subnet

  allocation_id = aws_eip.my_eip[each.key].id
  subnet_id     = each.value.id

  tags = {
    Name = "my_nat_gateway_${each.value.id}"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.my_internet_gw]
}

resource "aws_eip" "my_eip" {
  for_each = aws_subnet.my_private_subnet
  vpc      = true

  tags = {
    "Name" = "my_elastic_ip_${each.value.id}"
  }
}
