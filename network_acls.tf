locals {
  merged_public_inbound_acl_rules = merge(
    var.default_inbound_acl_rules,
    var.public_inbound_acl_rules
  )
  merged_public_outbound_acl_rules = merge(
    var.default_outbound_acl_rules,
    var.public_outbound_acl_rules
  )
  merged_private_with_nat_inbound_acl_rules = merge(
    var.default_inbound_acl_rules,
    var.private_with_nat_inbound_acl_rules
  )
  merged_private_with_nat_outbound_acl_rules = merge(
    var.default_outbound_acl_rules,
    var.private_with_nat_outbound_acl_rules
  )
  merged_private_inbound_acl_rules = merge(
    var.default_inbound_acl_rules,
    var.private_inbound_acl_rules
  )
  merged_private_outbound_acl_rules = merge(
    var.default_outbound_acl_rules,
    var.private_outbound_acl_rules
  )
}

# Public network ACL
resource "aws_network_acl" "my_public_acl" {
  vpc_id     = aws_vpc.my_vpc.id
  subnet_ids = [for k, v in aws_subnet.my_public_subnet : v.id]

  tags = {
    Name   = "my_public_acl"
    Deploy = "Terraform"
  }
}

resource "aws_network_acl_rule" "my_public_inbound" {
  for_each = local.merged_public_inbound_acl_rules

  egress         = false
  network_acl_id = aws_network_acl.my_public_acl.id
  rule_number    = each.value["rule_number"]
  rule_action    = each.value["rule_action"]
  protocol       = each.value["protocol"]
  from_port      = lookup(each.value, "from_port", null)
  to_port        = lookup(each.value, "to_port", null)
  cidr_block     = lookup(each.value, "cidr_block", null)
}

resource "aws_network_acl_rule" "my_public_outbound" {
  for_each = local.merged_public_outbound_acl_rules

  egress         = true
  network_acl_id = aws_network_acl.my_public_acl.id
  rule_number    = each.value["rule_number"]
  rule_action    = each.value["rule_action"]
  protocol       = each.value["protocol"]
  from_port      = lookup(each.value, "from_port", null)
  to_port        = lookup(each.value, "to_port", null)
  cidr_block     = lookup(each.value, "cidr_block", null)
}

# Private_with_nat network ACL
resource "aws_network_acl" "my_private_with_nat_acl" {
  vpc_id     = aws_vpc.my_vpc.id
  subnet_ids = [for k, v in aws_subnet.my_private_with_nat_subnet : v.id]

  tags = {
    Name   = "my_private_with_nat_acl"
    Deploy = "Terraform"
  }
}

resource "aws_network_acl_rule" "my_private_with_nat_inbound" {
  for_each = local.merged_private_with_nat_inbound_acl_rules

  egress         = false
  network_acl_id = aws_network_acl.my_private_with_nat_acl.id
  rule_number    = each.value["rule_number"]
  rule_action    = each.value["rule_action"]
  protocol       = each.value["protocol"]
  from_port      = lookup(each.value, "from_port", null)
  to_port        = lookup(each.value, "to_port", null)
  cidr_block     = lookup(each.value, "cidr_block", null)
}

resource "aws_network_acl_rule" "my_private_with_nat_outbound" {
  for_each = local.merged_private_with_nat_outbound_acl_rules

  egress         = true
  network_acl_id = aws_network_acl.my_private_with_nat_acl.id
  rule_number    = each.value["rule_number"]
  rule_action    = each.value["rule_action"]
  protocol       = each.value["protocol"]
  from_port      = lookup(each.value, "from_port", null)
  to_port        = lookup(each.value, "to_port", null)
  cidr_block     = lookup(each.value, "cidr_block", null)
}

# Private network ACL
resource "aws_network_acl" "my_private_acl" {
  vpc_id     = aws_vpc.my_vpc.id
  subnet_ids = [for k, v in aws_subnet.my_private_subnet : v.id]

  tags = {
    Name   = "my_private_acl"
    Deploy = "Terraform"
  }
}

resource "aws_network_acl_rule" "my_private_inbound" {
  for_each = local.merged_private_inbound_acl_rules

  egress         = false
  network_acl_id = aws_network_acl.my_private_acl.id
  rule_number    = each.value["rule_number"]
  rule_action    = each.value["rule_action"]
  protocol       = each.value["protocol"]
  from_port      = lookup(each.value, "from_port", null)
  to_port        = lookup(each.value, "to_port", null)
  cidr_block     = lookup(each.value, "cidr_block", null)
}

resource "aws_network_acl_rule" "my_private_outbound" {
  for_each = local.merged_private_outbound_acl_rules

  egress         = true
  network_acl_id = aws_network_acl.my_private_acl.id
  rule_number    = each.value["rule_number"]
  rule_action    = each.value["rule_action"]
  protocol       = each.value["protocol"]
  from_port      = lookup(each.value, "from_port", null)
  to_port        = lookup(each.value, "to_port", null)
  cidr_block     = lookup(each.value, "cidr_block", null)
}
