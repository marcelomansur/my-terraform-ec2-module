provider "aws" {
  region = var.aws_region
}

module "my_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.1.0"

  # VPC configuration
  name = "my-vpc"
  cidr = var.vpc_cidr
  # Subnets
  azs             = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  intra_subnets   = var.intra_subnets
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  # Enable NAT Gateway for private subnets
  enable_nat_gateway = true
  single_nat_gateway = false
  # Disable VPN gateway
  enable_vpn_gateway = false

  # Intra ACL
  intra_dedicated_network_acl = true
  intra_inbound_acl_rules     = concat(var.network_acls_default_inbound, var.network_acls_intra_inbound)
  intra_outbound_acl_rules    = concat(var.network_acls_default_outbound, var.network_acls_intra_outbound)
  # Public ACL
  public_dedicated_network_acl = true
  public_inbound_acl_rules     = concat(var.network_acls_default_inbound, var.network_acls_public_inbound)
  public_outbound_acl_rules    = concat(var.network_acls_default_outbound, var.network_acls_public_outbound)
  # Private ACL - used for management
  private_dedicated_network_acl = true
  private_inbound_acl_rules     = concat(var.network_acls_default_inbound, var.network_acls_private_inbound)
  private_outbound_acl_rules    = concat(var.network_acls_default_outbound, var.network_acls_private_outbound)

  # Tags
  intra_subnet_tags = {
    Name = "subnet-intra"
  }
  public_subnet_tags = {
    Name = "subnet-public"
  }
  private_subnet_tags = {
    Name = "subnet-private"
  }
  vpc_tags = {
    Name = "my-vpc"
  }
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
