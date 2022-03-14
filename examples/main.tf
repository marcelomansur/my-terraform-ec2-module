module "my_ec2" {
  source = "../"

  # AMI configuration
  # Ubuntu
  ami_name = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  # Canonical
  ami_owner = ["099720109477"]
  # VPC configuration
  vpc_name = "my_vpc"
  vpc_cidr = "10.0.0.0/16"
  # VPC Subnets
  private_subnets          = ["10.0.1.0/24"]
  public_subnets           = ["10.0.101.0/24"]
  private_with_nat_subnets = ["10.0.201.0/24"]
  # Network ACLs
  private_inbound_acl_rules = {
    mongodb = {
      rule_number = 110
      rule_action = "allow"
      from_port   = 27017
      to_port     = 27017
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
  }
  private_outbound_acl_rules = {
    mongodb = {
      rule_number = 110
      rule_action = "allow"
      from_port   = 27017
      to_port     = 27017
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
  }
  # Security groups
  private_inbound_sg_rules = {
    ssh-tcp = {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
    },
    mongodb-tcp = {
      from_port = 27017
      to_port   = 27017
      protocol  = "tcp"
    },
  }
  private_outbound_sg_rules = {
    ssh-tcp = {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
    },
    mongodb-tcp = {
      from_port = 27017
      to_port   = 27017
      protocol  = "tcp"
    },
  }
}
