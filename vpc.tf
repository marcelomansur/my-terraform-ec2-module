resource "aws_vpc" "my_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = merge(
    {
      "Name" = var.vpc_name
    },
    var.vpc_tags,
  )
}
