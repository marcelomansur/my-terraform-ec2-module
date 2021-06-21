locals {
  merged_public_sg_ingress_from_all = merge(
    var.default_sg_ingress_from_all,
    var.public_sg_ingress_from_all
  )
  merged_public_sg_egress_from_all = merge(
    var.default_sg_egress_from_all,
    var.public_sg_egress_from_all
  )
  merged_private_sg_ingress_with_source_public_sg = merge(
    var.default_sg_ingress_from_all,
    var.private_sg_ingress_with_source_public_sg
  )
  merged_private_sg_egress_with_source_public_sg = merge(
    var.default_sg_egress_from_all,
    var.private_sg_egress_with_source_public_sg
  )
  merged_intra_sg_ingress_with_source_public_sg = merge(
    var.default_sg_ingress_from_all,
    var.intra_sg_ingress_with_source_public_sg
  )
  merged_intra_sg_egress_with_source_public_sg = merge(
    var.default_sg_egress_from_all,
    var.intra_sg_egress_with_source_public_sg
  )
}

# Public security group
resource "aws_security_group" "my_public_sg" {
  name        = "my_public_sg"
  description = "Security group for public instances"
  vpc_id      = aws_vpc.my_vpc.id

  tags = {
    Name = "my_public_sg"
  }
}

# Inbound rules
resource "aws_security_group_rule" "my_public_sg_ingress_from_all" {
  for_each = local.merged_public_sg_ingress_from_all

  type              = "ingress"
  from_port         = each.value["from_port"]
  to_port           = each.value["to_port"]
  protocol          = each.value["protocol"]
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.my_public_sg.id
}

# Outbound rules
resource "aws_security_group_rule" "my_public_sg_egress_from_all" {
  for_each = local.merged_public_sg_egress_from_all

  type              = "egress"
  from_port         = each.value["from_port"]
  to_port           = each.value["to_port"]
  protocol          = each.value["protocol"]
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.my_public_sg.id
}

# Private security group
resource "aws_security_group" "my_private_sg" {
  name        = "my_private_sg"
  description = "Security group for private instances"
  vpc_id      = aws_vpc.my_vpc.id

  tags = {
    Name = "my_private_sg"
  }
}

# Inbound rules
resource "aws_security_group_rule" "my_private_sg_ingress_with_source_public_sg" {
  for_each = local.merged_private_sg_ingress_with_source_public_sg

  type                     = "ingress"
  from_port                = each.value["from_port"]
  to_port                  = each.value["to_port"]
  protocol                 = each.value["protocol"]
  source_security_group_id = aws_security_group.my_public_sg.id
  security_group_id        = aws_security_group.my_private_sg.id
}

# Outbound rules
resource "aws_security_group_rule" "my_private_sg_egress_with_source_public_sg" {
  for_each = local.merged_private_sg_egress_with_source_public_sg

  type              = "egress"
  from_port         = each.value["from_port"]
  to_port           = each.value["to_port"]
  protocol          = each.value["protocol"]
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.my_private_sg.id
}

# Intra security group
resource "aws_security_group" "my_intra_sg" {
  name        = "my_intra_sg"
  description = "Security group for intra instances"
  vpc_id      = aws_vpc.my_vpc.id

  tags = {
    Name = "my_intra_sg"
  }
}

# Inbound rules
resource "aws_security_group_rule" "my_intra_sg_ingress_with_source_public_sg" {
  for_each = local.merged_intra_sg_ingress_with_source_public_sg

  type                     = "ingress"
  from_port                = each.value["from_port"]
  to_port                  = each.value["to_port"]
  protocol                 = each.value["protocol"]
  source_security_group_id = aws_security_group.my_public_sg.id
  security_group_id        = aws_security_group.my_intra_sg.id
}

# Outbound rules
resource "aws_security_group_rule" "my_intra_sg_egress_with_source_public_sg" {
  for_each = local.merged_intra_sg_egress_with_source_public_sg

  type              = "egress"
  from_port         = each.value["from_port"]
  to_port           = each.value["to_port"]
  protocol          = each.value["protocol"]
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.my_intra_sg.id
}
