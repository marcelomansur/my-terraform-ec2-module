# SSH public key file
variable "my_key_file" {
  description = "The public ssh RSA key file used for connection"
  type        = string
  default     = "ssh/aws_rsa.pub"
}

# VPC
variable "vpc_name" {
  description = "The VPC name"
  type        = string
  default     = "my_vpc"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

# Subnets
variable "private_subnets" {
  description = "A list of private subnets"
  type        = list(string)
}

variable "public_subnets" {
  description = "A list of public subnets"
  type        = list(string)
}

variable "private_with_nat_subnets" {
  description = "A list of private_with_nat subnets"
  type        = list(string)
}

# EC2 instances
variable "webserver_instances" {
  description = "The EC2 instances for webserver cluster"
  type        = map(map(any))
  default = {
    webserver-example = {
      instance_name = "webserver-example"
      instance_type = "t2.micro"
      monitoring    = true
    },
  }
}

variable "monitoring_instances" {
  description = "The EC2 instances for monitoring cluster"
  type        = map(map(any))
  default = {
    monitoring-example = {
      instance_name = "monitoring-example"
      instance_type = "t2.micro"
      monitoring    = false
    },
  }
}

variable "database_instances" {
  description = "The EC2 instances for database cluster"
  type        = map(map(any))
  default = {
    database-example = {
      instance_name = "database-example"
      instance_type = "t2.micro"
      monitoring    = true
    },
  }
}

# Network ACLs
variable "default_inbound_acl_rules" {
  description = "The network ACLs default inbound rules"
  type        = map(map(any))
  default = {
    ssh = {
      rule_number = 100
      rule_action = "allow"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
    ephemeral = {
      rule_number = 901
      rule_action = "allow"
      from_port   = 1024
      to_port     = 65535
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
  }
}

variable "default_outbound_acl_rules" {
  description = "The network ACLs default outbound rules"
  type        = map(map(any))
  default = {
    ssh = {
      rule_number = 100
      rule_action = "allow"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
    ephemeral = {
      rule_number = 901
      rule_action = "allow"
      from_port   = 1024
      to_port     = 65535
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
  }
}

variable "public_inbound_acl_rules" {
  description = "The network ACLs public inbound rules"
  type        = map(map(any))
  default = {
    http = {
      rule_number = 110
      rule_action = "allow"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
    https = {
      rule_number = 120
      rule_action = "allow"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
  }
}

variable "public_outbound_acl_rules" {
  description = "The network ACLs public outbound rules"
  type        = map(map(any))
  default = {
    http = {
      rule_number = 110
      rule_action = "allow"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
    https = {
      rule_number = 120
      rule_action = "allow"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
  }
}

variable "private_with_nat_inbound_acl_rules" {
  description = "The network ACLs private_with_nat inbound rules"
  type        = map(map(any))
  default     = {}
}

variable "private_with_nat_outbound_acl_rules" {
  description = "The network ACLs private_with_nat outbound rules"
  type        = map(map(any))
  default = {
    http = {
      rule_number = 110
      rule_action = "allow"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
    https = {
      rule_number = 120
      rule_action = "allow"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
  }
}

variable "private_inbound_acl_rules" {
  description = "The network ACLs private inbound rules"
  type        = map(map(any))
  default     = {}
}

variable "private_outbound_acl_rules" {
  description = "The network ACLs private outbound rules"
  type        = map(map(any))
  default     = {}
}

# Security groups
variable "default_inbound_sg_rules" {
  description = "The network ACLs default inbound rules"
  type        = map(map(any))
  default = {
    ssh-tcp = {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
    },
  }
}

variable "default_outbound_sg_rules" {
  description = "The network ACLs default outbound rules"
  type        = map(map(any))
  default = {
    ssh-tcp = {
      from_port = 0
      to_port   = 0
      protocol  = -1
    },
  }
}

variable "public_inbound_sg_rules" {
  description = "The network ACLs public inbound rules"
  type        = map(map(any))
  default = {
    http-tcp = {
      from_port = 80
      to_port   = 80
      protocol  = "tcp"
    },
    https-tcp = {
      from_port = 443
      to_port   = 443
      protocol  = "tcp"
    }
  }
}

variable "public_outbound_sg_rules" {
  description = "The network ACLs public outbound rules"
  type        = map(map(any))
  default     = {}
}

variable "private_with_nat_inbound_sg_rules" {
  description = "The network ACLs private_with_nat inbound rules"
  type        = map(map(any))
  default     = {}
}

variable "private_with_nat_outbound_sg_rules" {
  description = "The network ACLs private_with_nat outbound rules"
  type        = map(map(any))
  default     = {}
}

variable "private_inbound_sg_rules" {
  description = "The network ACLs private inbound rules"
  type        = map(map(any))
  default     = {}
}

variable "private_outbound_sg_rules" {
  description = "The network ACLs private outbound rules"
  type        = map(map(any))
  default     = {}
}
