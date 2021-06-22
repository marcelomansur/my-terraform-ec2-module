locals {
  merged_public_inbound_sg_rules = merge(
    var.default_inbound_sg_rules,
    var.public_inbound_sg_rules
  )
  merged_public_outbound_sg_rules = merge(
    var.default_outbound_sg_rules,
    var.public_outbound_sg_rules
  )
  merged_private_inbound_sg_rules = merge(
    var.default_inbound_sg_rules,
    var.private_inbound_sg_rules
  )
  merged_private_outbound_sg_rules = merge(
    var.default_outbound_sg_rules,
    var.private_outbound_sg_rules
  )
  merged_intra_inbound_sg_rules = merge(
    var.default_inbound_sg_rules,
    var.intra_inbound_sg_rules
  )
  merged_intra_outbound_sg_rules = merge(
    var.default_outbound_sg_rules,
    var.intra_outbound_sg_rules
  )
}

# Public security group
resource "aws_security_group" "my_public_sg" {
  name        = "my_public_sg"
  description = "Security group for public instances"
  vpc_id      = aws_vpc.my_vpc.id

  tags = {
    Name   = "my_public_sg"
    Deploy = "Terraform"
  }
}

# Inbound rules
resource "aws_security_group_rule" "my_public_inbound_sg_rules" {
  for_each = local.merged_public_inbound_sg_rules

  type              = "ingress"
  from_port         = each.value["from_port"]
  to_port           = each.value["to_port"]
  protocol          = each.value["protocol"]
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.my_public_sg.id
}

# Outbound rules
resource "aws_security_group_rule" "my_public_outbound_sg_rules" {
  for_each = local.merged_public_outbound_sg_rules

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
    Name   = "my_private_sg"
    Deploy = "Terraform"
  }
}

# Inbound rules
resource "aws_security_group_rule" "my_private_inbound_sg_rules" {
  for_each = local.merged_private_inbound_sg_rules

  type                     = "ingress"
  from_port                = each.value["from_port"]
  to_port                  = each.value["to_port"]
  protocol                 = each.value["protocol"]
  source_security_group_id = aws_security_group.my_public_sg.id
  security_group_id        = aws_security_group.my_private_sg.id
}

# Outbound rules
resource "aws_security_group_rule" "my_private_outbound_sg_rules" {
  for_each = local.merged_private_outbound_sg_rules

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
    Name   = "my_intra_sg"
    Deploy = "Terraform"
  }
}

# Inbound rules
resource "aws_security_group_rule" "my_intra_inbound_sg_rules" {
  for_each = local.merged_intra_inbound_sg_rules

  type                     = "ingress"
  from_port                = each.value["from_port"]
  to_port                  = each.value["to_port"]
  protocol                 = each.value["protocol"]
  source_security_group_id = aws_security_group.my_public_sg.id
  security_group_id        = aws_security_group.my_intra_sg.id
}

# Outbound rules
resource "aws_security_group_rule" "my_intra_outbound_sg_rules" {
  for_each = local.merged_intra_outbound_sg_rules

  type              = "egress"
  from_port         = each.value["from_port"]
  to_port           = each.value["to_port"]
  protocol          = each.value["protocol"]
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.my_intra_sg.id
}
