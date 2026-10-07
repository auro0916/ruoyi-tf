variable "name_prefix" {
  description = "Prefix used for resource names"
  type        = string
}

variable "ami_id" {
  description = "AMI ID used by the bastion EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the bastion"
  type        = string
}

variable "key_name" {
  description = "AWS EC2 key pair name"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID for the bastion"
  type        = string
}

variable "ec2_sg_id" {
  description = "Security group ID for the bastion"
  type        = string
}