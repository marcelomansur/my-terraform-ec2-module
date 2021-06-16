module "my_intra_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.2.0"

  name        = "my-intra-security-group"
  description = "Security group for intra instances"
  vpc_id      = module.my_vpc.vpc_id

  ingress_with_source_security_group_id = [
    {
      rule                     = "ssh-tcp"
      source_security_group_id = module.my_public_security_group.security_group_id
    },
    {
      rule                     = "mongodb-27017-tcp"
      source_security_group_id = module.my_public_security_group.security_group_id
    },
  ]
  egress_with_source_security_group_id = [
    {
      rule                     = "ssh-tcp"
      source_security_group_id = module.my_public_security_group.security_group_id
    },
    {
      rule                     = "mongodb-27017-tcp"
      source_security_group_id = module.my_public_security_group.security_group_id
    },
  ]
}

module "my_public_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.2.0"

  name        = "my-public-security-group"
  description = "Security group for public instances"
  vpc_id      = module.my_vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      cidr_blocks = var.my_personal_ip
    },
    {
      rule        = "http-80-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "https-443-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["https-443-tcp", "http-80-tcp", "ssh-tcp"]
}

module "my_private_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.2.0"

  name        = "my-private-security-group"
  description = "Security group for private instances"
  vpc_id      = module.my_vpc.vpc_id

  ingress_with_source_security_group_id = [
    {
      rule                     = "ssh-tcp"
      source_security_group_id = module.my_public_security_group.security_group_id
    },
  ]
  egress_with_source_security_group_id = [
    {
      rule                     = "ssh-tcp"
      source_security_group_id = module.my_public_security_group.security_group_id
    },
  ]
}
