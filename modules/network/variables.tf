variable "name_prefix" {
  description = "Prefix used for resource names"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_a_cidr" {
  description = "CIDR block for public subnet A"
  type        = string
}

variable "public_subnet_c_cidr" {
  description = "CIDR block for public subnet C"
  type        = string
}

variable "az_a" {
  description = "Availability Zone A"
  type        = string
}

variable "az_c" {
  description = "Availability Zone C"
  type        = string
}

variable "private_subnets" {
  description = "Private application subnets"

  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "db_subnets" {
  description = "Private database subnets"

  type = map(object({
    cidr = string
    az   = string
  }))
}