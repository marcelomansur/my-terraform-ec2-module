# AWS EC2 environment Terraform module

Terraform module which creates a complete EC2 environment on AWS.

This module is the result of my personal studies using Terraform in AWS. These are the mainly concepts used:

- VPC Network
- Subnets:
  - public = webserver
  - private_with_nat = monitoring
  - private = database
- Network ACLs
- Security groups
- Route tables
- Internet gateway
- NAT gateway
- EC2 instances

## Usage

```hcl
module "ec2_cluster" {
  source                 = "github.com/marcelomansur/my-terraform-ec2-module"
  version                = "v0.1"

  aws_region = "us-east-1"
  # VPC cidr blocks used
  vpc_name = "my_vpc"
  vpc_cidr = "10.0.0.0/16"
  # VPC Subnets
  public_subnets           = ["10.0.101.0/24"]
  private_with_nat_subnets = ["10.0.201.0/24"]
  private_subnets          = ["10.0.1.0/24"]
  # EC2 instances
  webserver_instances = {
    webserver-example = {
      instance_name = "webserver-example"
      instance_type = "t2.micro",
    }
  }
  monitoring_instances = {
    monitoring-example = {
      instance_name = "monitoring-example"
      instance_type = "t2.micro"
    }
  }
  database_instances = {
    database-example = {
      instance_name = "database-example"
      instance_type = "t2.micro"
    }
  }
}
```

## Examples

- This [basic example](examples) shows how to use this module to create a basic environment with 3 instances and 3 subnets.

## Subnet types variables

A virtual private cloud (VPC) is a virtual network dedicated to your AWS account. It is logically isolated from other virtual networks in the AWS Cloud. After creating a VPC, you can add one or more subnets. This module provides three subnet types to build an environment:

- `public_subnets`: List of subnets used for webservers. They have a public IP and internet access provided by a Internet Gateway. Users can connect to it using SSH key pairs informed on variable `my_key_file`.
- `private_with_nat_subnets`: List of subnets used for monitoring or middlewares. It has outbound internet access using a NAT Gateway.
- `private_subnets`: List of subnets used for databases. It has NOT internet access.

## Network ACLs variables

A network access control list (ACL) is an optional layer of security for your VPC that acts as a firewall for controlling traffic in and out of one or more subnets. In this module, each subnet has a network ACL associated to it:

- `default_inbound_acl_rules` and `default_outbound_acl_rules`: Inbound and outbound rules merged to all others subnet. Put the default rules here and don't repeat it on others variables.
- `public_inbound_acl_rules` and `public_outbound_acl_rules`: Inbound and outbound rules for the public subnet. It opens ports like `http` and `https`.
- `private_with_nat_inbound_acl_rules` and `private_with_nat_outbound_acl_rules`: Inbound and outbound rules for the private_with_nat subnet. It opens ports like `http` and `https` for outbound rules.
- `private_inbound_acl_rules` and `private_outbound_acl_rules`: Inbound and outbound rules for the private subnet. It must contain the most restrictive rules.

> For study purposes, this module configures SSH port open by default for all subnets.

## Security groups variables

A security group (SG) acts as a virtual firewall for your instance to control inbound and outbound traffic. This module provides these security group types:
- `default_inbound_sg_rules` and `default_outbound_sg_rules`: Inbound and outbound rules merged to all others subnet. Put the default rules here and don't repeat it on others variables.
- `public_inbound_sg_rules` and `public_outbound_sg_rules`: Inbound and outbound rules for the public instances. It opens ports like `http` and `https`.
- `private_with_nat_inbound_sg_rules` and `private_with_nat_outbound_sg_rules`: Inbound and outbound rules for the private_with_nat instances.
- `private_inbound_sg_rules` and `private_outbound_sg_rules`: Inbound and outbound rules for the private instance. It must contain the most restrictive rules.

> For study purposes, this module configures SSH port open by default for all subnets.

## EC2 instances variables

A Elastic Compute Cloud (EC2) is a web service that provides secure, resizable compute capacity in the cloud. This module provides some EC2 instances:
- `webserver_instances`: Map of objects, each one represents a instance of webserver.
- `monitoring_instances`: Map of objects, each one represents a instance of monitoring server.
- `database_instances`: Map of objects, each one represents a instance of database server.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| aws | 3.44.0 |

## Providers

| Name | Version |
|------|---------|
| aws | 3.44.0 |

## Resources

| Name |
|------|
| [aws_ami](https://registry.terraform.io/providers/hashicorp/aws/3.44.0/docs/data-sources/ami) |
| [aws_eip](https://registry.terraform.io/providers/hashicorp/aws/3.44.0/docs/resources/eip) |
| [aws_instance](https://registry.terraform.io/providers/hashicorp/aws/3.44.0/docs/resources/instance) |
| [aws_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/3.44.0/docs/resources/internet_gateway) |
| [aws_key_pair](https://registry.terraform.io/providers/hashicorp/aws/3.44.0/docs/resources/key_pair) |
| [aws_nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/3.44.0/docs/resources/nat_gateway) |
| [aws_network_acl](https://registry.terraform.io/providers/hashicorp/aws/3.44.0/docs/resources/network_acl) |
| [aws_network_acl_rule](https://registry.terraform.io/providers/hashicorp/aws/3.44.0/docs/resources/network_acl_rule) |
| [aws_route_table](https://registry.terraform.io/providers/hashicorp/aws/3.44.0/docs/resources/route_table) |
| [aws_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/3.44.0/docs/resources/route_table_association) |
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/3.44.0/docs/resources/security_group) |
| [aws_security_group_rule](https://registry.terraform.io/providers/hashicorp/aws/3.44.0/docs/resources/security_group_rule) |
| [aws_subnet](https://registry.terraform.io/providers/hashicorp/aws/3.44.0/docs/resources/subnet) |
| [aws_vpc](https://registry.terraform.io/providers/hashicorp/aws/3.44.0/docs/resources/vpc) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami\_name | A list of names for searching the AMI | `list(string)` | <pre>[<br>  "iac-ubuntu-v0.3*"<br>]</pre> | no |
| ami\_owner | A list of owners for searching the AMI | `list(string)` | <pre>[<br>  "self"<br>]</pre> | no |
| my\_key\_file | The public ssh RSA key file used for connection | `string` | `"ssh/aws_rsa.pub"` | no |
| vpc\_name | The VPC name | `string` | `"my_vpc"` | no |
| vpc\_cidr | The CIDR block for the VPC | `string` | n/a | yes |
| vpc\_tags | Tags to identify VPC | `map(string)` | `{}` | no |
| public\_subnets | A list of public subnets | `list(string)` | n/a | yes |
| private_with_nat\_subnets | A list of private subnets with a NAT gateway | `list(string)` | n/a | yes |
| private\_subnets | A list of private subnets | `list(string)` | n/a | yes |
| default\_inbound\_acl\_rules | The network ACLs default inbound rules | `map(map(any))` | <pre>{<br>  "ephemeral": {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 1024,<br>    "protocol": "tcp",<br>    "rule_action": "allow",<br>    "rule_number": 901,<br>    "to_port": 65535<br>  },<br>  "ssh": {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 22,<br>    "protocol": "tcp",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 22<br>  }<br>}</pre> | no |
| default\_outbound\_acl\_rules | The network ACLs default outbound rules | `map(map(any))` | <pre>{<br>  "ephemeral": {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 1024,<br>    "protocol": "tcp",<br>    "rule_action": "allow",<br>    "rule_number": 901,<br>    "to_port": 65535<br>  },<br>  "ssh": {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 22,<br>    "protocol": "tcp",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 22<br>  }<br>}</pre> | no |
| public\_inbound\_acl\_rules | The network ACLs public inbound rules | `map(map(any))` | <pre>{<br>  "http": {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 80,<br>    "protocol": "tcp",<br>    "rule_action": "allow",<br>    "rule_number": 110,<br>    "to_port": 80<br>  },<br>  "https": {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 443,<br>    "protocol": "tcp",<br>    "rule_action": "allow",<br>    "rule_number": 120,<br>    "to_port": 443<br>  }<br>}</pre> | no |
| public\_outbound\_acl\_rules | The network ACLs public outbound rules | `map(map(any))` | <pre>{<br>  "http": {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 80,<br>    "protocol": "tcp",<br>    "rule_action": "allow",<br>    "rule_number": 110,<br>    "to_port": 80<br>  },<br>  "https": {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 443,<br>    "protocol": "tcp",<br>    "rule_action": "allow",<br>    "rule_number": 120,<br>    "to_port": 443<br>  }<br>}</pre> | no |
| private_with_nat\_inbound\_acl\_rules | The network ACLs private_with_nat inbound rules | `map(map(any))` | `{}` | no |
| private_with_nat\_outbound\_acl\_rules | The network ACLs private_with_nat outbound rules | `map(map(any))` | <pre>{<br>  "http": {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 80,<br>    "protocol": "tcp",<br>    "rule_action": "allow",<br>    "rule_number": 110,<br>    "to_port": 80<br>  },<br>  "https": {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 443,<br>    "protocol": "tcp",<br>    "rule_action": "allow",<br>    "rule_number": 120,<br>    "to_port": 443<br>  }<br>}</pre> | no |
| private\_inbound\_acl\_rules | The network ACLs private inbound rules | `map(map(any))` | `{}` | no |
| private\_outbound\_acl\_rules | The network ACLs private outbound rules | `map(map(any))` | `{}` | no |
| default\_inbound\_sg\_rules | The network ACLs default inbound rules | `map(map(any))` | <pre>{<br>  "ssh-tcp": {<br>    "from_port": 22,<br>    "protocol": "tcp",<br>    "to_port": 22<br>  }<br>}</pre> | no |
| default\_outbound\_sg\_rules | The network ACLs default outbound rules | `map(map(any))` | <pre>{<br>  "ssh-tcp": {<br>    "from_port": 0,<br>    "protocol": -1,<br>    "to_port": 0<br>  }<br>}</pre> | no |
| public\_inbound\_sg\_rules | The network ACLs public inbound rules | `map(map(any))` | <pre>{<br>  "http-tcp": {<br>    "from_port": 80,<br>    "protocol": "tcp",<br>    "to_port": 80<br>  },<br>  "https-tcp": {<br>    "from_port": 443,<br>    "protocol": "tcp",<br>    "to_port": 443<br>  }<br>}</pre> | no |
| public\_outbound\_sg\_rules | The network ACLs public outbound rules | `map(map(any))` | `{}` | no |
| private_with_nat\_inbound\_sg\_rules | The network ACLs private_with_nat inbound rules | `map(map(any))` | `{}` | no |
| private_with_nat\_outbound\_sg\_rules | The network ACLs private_with_nat outbound rules | `map(map(any))` | `{}` | no |
| private\_inbound\_sg\_rules | The network ACLs private inbound rules | `map(map(any))` | `{}` | no |
| private\_outbound\_sg\_rules | The network ACLs private outbound rules | `map(map(any))` | `{}` | no |
| webserver\_instances | The EC2 instances for webserver cluster | `map(map(any))` | <pre>{<br>  "webserver-example": {<br>    "instance_name": "webserver-example",<br>    "instance_type": "t2.micro",<br>    "monitoring": true<br>  }<br>}</pre> | no |
| monitoring\_instances | The EC2 instances for monitoring cluster | `map(map(any))` | <pre>{<br>  "monitoring-example": {<br>    "instance_name": "monitoring-example",<br>    "instance_type": "t2.micro",<br>    "monitoring": false<br>  }<br>}</pre> | no |
| database\_instances | The EC2 instances for database cluster | `map(map(any))` | <pre>{<br>  "database-example": {<br>    "instance_name": "database-example",<br>    "instance_type": "t2.micro",<br>    "monitoring": true<br>  }<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| webserver\_public\_ip | EC2 webserver instance public IP |
| webserver\_private\_ip | EC2 webserver instance private IP |
| monitoring\_private\_ip | EC2 monitoring instance private IP |
| database\_private\_ip | EC2 database instance private IP |
