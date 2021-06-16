# Personal variables
my_public_key  = ""
my_personal_ip = ""
# VPC cidr
vpc_cidr = "10.0.0.0/16"
# VPC Subnets
intra_subnets   = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
private_subnets = ["10.0.201.0/24", "10.0.202.0/24", "10.0.203.0/24"]
# Network ACLs
network_acls_default_inbound = [
  {
    rule_number = 900
    rule_action = "allow"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_block  = "0.0.0.0/0"
  },
  {
    rule_number = 901
    rule_action = "allow"
    from_port   = 1024
    to_port     = 65535
    protocol    = "tcp"
    cidr_block  = "0.0.0.0/0"
  },
]
network_acls_default_outbound = [
  {
    rule_number = 900
    rule_action = "allow"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_block  = "0.0.0.0/0"
  },
  {
    rule_number = 901
    rule_action = "allow"
    from_port   = 32768
    to_port     = 65535
    protocol    = "tcp"
    cidr_block  = "0.0.0.0/0"
  },
]
network_acls_public_inbound = [
  {
    rule_number = 100
    rule_action = "allow"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_block  = "0.0.0.0/0"
  },
  {
    rule_number = 110
    rule_action = "allow"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_block  = "0.0.0.0/0"
  },
  {
    rule_number = 120
    rule_action = "allow"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_block  = "0.0.0.0/0"
  },
]
network_acls_public_outbound = [
  {
    rule_number = 100
    rule_action = "allow"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_block  = "0.0.0.0/0"
  },
  {
    rule_number = 110
    rule_action = "allow"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_block  = "0.0.0.0/0"
  },
  {
    rule_number = 120
    rule_action = "allow"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_block  = "0.0.0.0/0"
  },
]
