## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| aws | 3.44.0 |

## Providers

| Name | Version |
|------|---------|
| aws | 3.44.0 |

## Modules

No Modules.

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
| aws\_region | The AWS region | `string` | `"us-east-1"` | no |
| default\_inbound\_acl\_rules | The network ACLs default inbound rules | `map(map(any))` | <pre>{<br>  "ephemeral": {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 1024,<br>    "protocol": "tcp",<br>    "rule_action": "allow",<br>    "rule_number": 901,<br>    "to_port": 65535<br>  },<br>  "ssh": {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 22,<br>    "protocol": "tcp",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 22<br>  }<br>}</pre> | no |
| default\_inbound\_sg\_rules | The network ACLs default inbound rules | `map(map(any))` | <pre>{<br>  "ssh-tcp": {<br>    "from_port": 22,<br>    "protocol": "tcp",<br>    "to_port": 22<br>  }<br>}</pre> | no |
| default\_outbound\_acl\_rules | The network ACLs default outbound rules | `map(map(any))` | <pre>{<br>  "ephemeral": {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 1024,<br>    "protocol": "tcp",<br>    "rule_action": "allow",<br>    "rule_number": 901,<br>    "to_port": 65535<br>  },<br>  "ssh": {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 22,<br>    "protocol": "tcp",<br>    "rule_action": "allow",<br>    "rule_number": 100,<br>    "to_port": 22<br>  }<br>}</pre> | no |
| default\_outbound\_sg\_rules | The network ACLs default outbound rules | `map(map(any))` | <pre>{<br>  "ssh-tcp": {<br>    "from_port": 0,<br>    "protocol": -1,<br>    "to_port": 0<br>  }<br>}</pre> | no |
| intra\_inbound\_acl\_rules | The network ACLs intra inbound rules | `map(map(any))` | `{}` | no |
| intra\_inbound\_sg\_rules | The network ACLs intra inbound rules | `map(map(any))` | `{}` | no |
| intra\_outbound\_acl\_rules | The network ACLs intra outbound rules | `map(map(any))` | `{}` | no |
| intra\_outbound\_sg\_rules | The network ACLs intra outbound rules | `map(map(any))` | `{}` | no |
| intra\_subnets | A list of intra subnets | `list(string)` | n/a | yes |
| my\_key\_file | The public ssh RSA key file used for connection | `string` | `"ssh/aws_rsa.pub"` | no |
| private\_inbound\_acl\_rules | The network ACLs private inbound rules | `map(map(any))` | `{}` | no |
| private\_inbound\_sg\_rules | The network ACLs private inbound rules | `map(map(any))` | `{}` | no |
| private\_outbound\_acl\_rules | The network ACLs private outbound rules | `map(map(any))` | <pre>{<br>  "http": {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 80,<br>    "protocol": "tcp",<br>    "rule_action": "allow",<br>    "rule_number": 110,<br>    "to_port": 80<br>  },<br>  "https": {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 443,<br>    "protocol": "tcp",<br>    "rule_action": "allow",<br>    "rule_number": 120,<br>    "to_port": 443<br>  }<br>}</pre> | no |
| private\_outbound\_sg\_rules | The network ACLs private outbound rules | `map(map(any))` | `{}` | no |
| private\_subnets | A list of private subnets | `list(string)` | n/a | yes |
| public\_inbound\_acl\_rules | The network ACLs public inbound rules | `map(map(any))` | <pre>{<br>  "http": {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 80,<br>    "protocol": "tcp",<br>    "rule_action": "allow",<br>    "rule_number": 110,<br>    "to_port": 80<br>  },<br>  "https": {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 443,<br>    "protocol": "tcp",<br>    "rule_action": "allow",<br>    "rule_number": 120,<br>    "to_port": 443<br>  }<br>}</pre> | no |
| public\_inbound\_sg\_rules | The network ACLs public inbound rules | `map(map(any))` | <pre>{<br>  "http-tcp": {<br>    "from_port": 80,<br>    "protocol": "tcp",<br>    "to_port": 80<br>  },<br>  "https-tcp": {<br>    "from_port": 443,<br>    "protocol": "tcp",<br>    "to_port": 443<br>  }<br>}</pre> | no |
| public\_outbound\_acl\_rules | The network ACLs public outbound rules | `map(map(any))` | <pre>{<br>  "http": {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 80,<br>    "protocol": "tcp",<br>    "rule_action": "allow",<br>    "rule_number": 110,<br>    "to_port": 80<br>  },<br>  "https": {<br>    "cidr_block": "0.0.0.0/0",<br>    "from_port": 443,<br>    "protocol": "tcp",<br>    "rule_action": "allow",<br>    "rule_number": 120,<br>    "to_port": 443<br>  }<br>}</pre> | no |
| public\_outbound\_sg\_rules | The network ACLs public outbound rules | `map(map(any))` | `{}` | no |
| public\_subnets | A list of public subnets | `list(string)` | n/a | yes |
| vpc\_cidr | The CIDR block for the VPC | `string` | n/a | yes |
| vpc\_name | The VPC name | `string` | `"my_vpc"` | no |
| vpc\_tags | Tags to identify VPC | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| database\_private\_ip | EC2 instance database IP |
| monitoring\_private\_ip | EC2 instance private IP |
| webserver\_private\_ip | EC2 instance private IP |
| webserver\_public\_ip | EC2 instance public IP |
