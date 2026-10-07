variable "name_prefix" {
  description = "Prefix used for resource names"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private application subnet IDs used by ElastiCache"
  type        = list(string)
}

variable "redis_sg_id" {
  description = "Redis security group ID"
  type        = string
}

variable "node_type" {
  description = "ElastiCache node type"
  type        = string
}