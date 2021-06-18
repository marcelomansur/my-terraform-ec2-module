module "my_ec2" {
  source = "../"

  # Personal variables
  # my_personal_ip = ""
  # VPC cidr
  vpc_name = "my_vpc"
  vpc_cidr = "10.0.0.0/16"
  # VPC Subnets
  intra_subnets   = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  private_subnets = ["10.0.201.0/24", "10.0.202.0/24", "10.0.203.0/24"]
  # Network ACLs
  public_inbound_acl_rules = {
    "http" = {
      "rule_number" = 110
      "rule_action" = "allow"
      "from_port"   = 80
      "to_port"     = 80
      "protocol"    = "tcp"
      "cidr_block"  = "0.0.0.0/0"
    },
    "https" = {
      "rule_number" = 120
      "rule_action" = "allow"
      "from_port"   = 443
      "to_port"     = 443
      "protocol"    = "tcp"
      "cidr_block"  = "0.0.0.0/0"
    },
  }
  public_outbound_acl_rules = {
    "http" = {
      "rule_number" = 110
      "rule_action" = "allow"
      "from_port"   = 80
      "to_port"     = 80
      "protocol"    = "tcp"
      "cidr_block"  = "0.0.0.0/0"
    },
    "https" = {
      "rule_number" = 120
      "rule_action" = "allow"
      "from_port"   = 443
      "to_port"     = 443
      "protocol"    = "tcp"
      "cidr_block"  = "0.0.0.0/0"
    },
  }
  intra_inbound_acl_rules = {
    "mongodb" = {
      "rule_number" = 110
      "rule_action" = "allow"
      "from_port"   = 27017
      "to_port"     = 27017
      "protocol"    = "tcp"
      "cidr_block"  = "0.0.0.0/0"
    },
  }
  intra_outbound_acl_rules = {
    "mongodb" = {
      "rule_number" = 110
      "rule_action" = "allow"
      "from_port"   = 27017
      "to_port"     = 27017
      "protocol"    = "tcp"
      "cidr_block"  = "0.0.0.0/0"
    },
  }
}
