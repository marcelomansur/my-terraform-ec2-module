data "aws_ami" "packer_ami" {
  most_recent = true

  owners = ["self"]

  filter {
    name   = "name"
    values = ["iac-ubuntu-v0.3*"]
  }
}

module "my_key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "my-tf-keypair"
  public_key = file(var.my_key_file)
}

module "my_ec2_database_cluster" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  ami            = data.aws_ami.packer_ami.id
  name           = "my-database-cluster"
  instance_type  = "t2.micro"
  instance_count = 1
  # monitoring             = true

  key_name                    = module.my_key_pair.key_pair_key_name
  vpc_security_group_ids      = [module.my_intra_security_group.security_group_id]
  subnet_ids                  = module.my_vpc.intra_subnets
  associate_public_ip_address = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "my_ec2_database_cluster"
  }
}

module "my_ec2_webserver_cluster" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  ami            = data.aws_ami.packer_ami.id
  name           = "my-webserver-cluster"
  instance_type  = "t2.micro"
  instance_count = 1
  # monitoring             = true

  key_name                    = module.my_key_pair.key_pair_key_name
  vpc_security_group_ids      = [module.my_public_security_group.security_group_id]
  subnet_ids                  = module.my_vpc.public_subnets
  associate_public_ip_address = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "my_ec2_webserver_cluster"
  }
}

module "my_ec2_monitoring_cluster" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  ami            = data.aws_ami.packer_ami.id
  name           = "my-monitoring-cluster"
  instance_type  = "t2.micro"
  instance_count = 1
  # monitoring             = true

  key_name               = module.my_key_pair.key_pair_key_name
  vpc_security_group_ids = [module.my_private_security_group.security_group_id]
  subnet_ids             = module.my_vpc.private_subnets

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "my_ec2_monitoring_cluster"
  }
}
