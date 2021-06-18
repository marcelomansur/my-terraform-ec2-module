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
  default     = {}
}

variable "public_outbound_acl_rules" {
  description = "The network ACLs public outbound rules"
  type        = map(map(any))
  default     = {}
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
