variable "aws_region" {
  description = "The AWS region"
  type        = string
  default     = "us-east-1"
}

variable "my_personal_ip" {
  description = "User personal computer IP"
  type        = string
}

variable "my_key_file" {
  description = "The public ssh RSA key file used for connection"
  type        = string
  default     = "ssh/aws_rsa.pub"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

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

variable "network_acls_default_inbound" {
  description = "The network ACLs default inbound rules"
  type = list(object({
    rule_number = number
    rule_action = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
  }))
  default = [
    {
      rule_number = 900
      rule_action = "allow"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number = 901
      rule_action = "allow"
      from_port   = 1024
      to_port     = 65535
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable "network_acls_default_outbound" {
  description = "The network ACLs default outbound rules"
  type = list(object({
    rule_number = number
    rule_action = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
  }))
  default = [
    {
      rule_number = 900
      rule_action = "allow"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number = 901
      rule_action = "allow"
      from_port   = 32768
      to_port     = 65535
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable "network_acls_intra_inbound" {
  description = "The network ACLs intra inbound rules"
  type = list(object({
    rule_number = number
    rule_action = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
  }))
  default = []
}

variable "network_acls_intra_outbound" {
  description = "The network ACLs intra outbound rules"
  type = list(object({
    rule_number = number
    rule_action = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
  }))
  default = []
}

variable "network_acls_public_inbound" {
  description = "The network ACLs public inbound rules"
  type = list(object({
    rule_number = number
    rule_action = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
  }))
  default = []
}

variable "network_acls_public_outbound" {
  description = "The network ACLs public outbound rules"
  type = list(object({
    rule_number = number
    rule_action = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
  }))
  default = []
}


variable "network_acls_private_inbound" {
  description = "The network ACLs private inbound rules"
  type = list(object({
    rule_number = number
    rule_action = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
  }))
  default = []
}

variable "network_acls_private_outbound" {
  description = "The network ACLs private outbound rules"
  type = list(object({
    rule_number = number
    rule_action = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
  }))
  default = []
}
