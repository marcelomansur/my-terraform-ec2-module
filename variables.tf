# AWS region
variable "aws_region" {
  description = "The AWS region"
  type        = string
  default     = "us-east-1"
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

variable "vpc_tags" {
  description = "Tags to identify VPC"
  type        = map(string)
  default     = {}
}

# Subnets
variable "intra_subnets" {
  description = "A list of intra subnets"
  type        = list(string)
}

variable "public_subnets" {
  description = "A list of public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "A list of private subnets"
  type        = list(string)
}

# Network ACLs
variable "default_inbound_acl_rules" {
  description = "The network ACLs default inbound rules"
  type        = map(map(any))
  default = {
    "ssh" = {
      "rule_number" = 100
      "rule_action" = "allow"
      "from_port"   = 22
      "to_port"     = 22
      "protocol"    = "tcp"
      "cidr_block"  = "0.0.0.0/0"
    },
  }
}

variable "default_outbound_acl_rules" {
  description = "The network ACLs default outbound rules"
  type        = map(map(any))
  default = {
    "ssh" = {
      "rule_number" = 100
      "rule_action" = "allow"
      "from_port"   = 22
      "to_port"     = 22
      "protocol"    = "tcp"
      "cidr_block"  = "0.0.0.0/0"
    },
  }
}

variable "public_inbound_acl_rules" {
  description = "The network ACLs public inbound rules"
  type        = map(map(any))
  default = {
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
}

variable "public_outbound_acl_rules" {
  description = "The network ACLs public outbound rules"
  type        = map(map(any))
  default = {
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

variable "intra_inbound_acl_rules" {
  description = "The network ACLs intra inbound rules"
  type        = map(map(any))
  default     = {}
}

variable "intra_outbound_acl_rules" {
  description = "The network ACLs intra outbound rules"
  type        = map(map(any))
  default     = {}
}

# Security groups
variable "default_sg_ingress_from_all" {
  description = "The network ACLs default inbound rules"
  type        = map(map(any))
  default = {
    "ssh-tcp" = {
      "from_port" = 22
      "to_port"   = 22
      "protocol"  = "tcp"
    },
  }
}

variable "default_sg_egress_from_all" {
  description = "The network ACLs default outbound rules"
  type        = map(map(any))
  default = {
    "ssh-tcp" = {
      "from_port" = 0
      "to_port"   = 0
      "protocol"  = -1
    },
  }
}

variable "public_sg_ingress_from_all" {
  description = "The network ACLs public inbound rules"
  type        = map(map(any))
  default = {
    "http-tcp" = {
      "from_port" = 80
      "to_port"   = 80
      "protocol"  = "tcp"
    },
    "https-tcp" = {
      "from_port" = 443
      "to_port"   = 443
      "protocol"  = "tcp"
    }
  }
}

variable "public_sg_egress_from_all" {
  description = "The network ACLs public outbound rules"
  type        = map(map(any))
  default     = {}
}

variable "private_sg_ingress_with_source_public_sg" {
  description = "The network ACLs private inbound rules"
  type        = map(map(any))
  default     = {}
}

variable "private_sg_egress_with_source_public_sg" {
  description = "The network ACLs private outbound rules"
  type        = map(map(any))
  default     = {}
}

variable "intra_sg_ingress_with_source_public_sg" {
  description = "The network ACLs intra inbound rules"
  type        = map(map(any))
  default     = {}
}

variable "intra_sg_egress_with_source_public_sg" {
  description = "The network ACLs intra outbound rules"
  type        = map(map(any))
  default     = {}
}
