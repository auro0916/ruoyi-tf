variable "name_prefix" {
  description = "Prefix used for resource names"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private application subnet IDs used by ECS"
  type        = list(string)
}

variable "app_sg_id" {
  description = "Application security group ID"
  type        = string
}

variable "target_group_arn" {
  description = "ALB target group ARN"
  type        = string
}

variable "ecr_repository_url" {
  description = "ECR repository URL containing the backend image"
  type        = string
}

variable "image_tag" {
  description = "Backend container image tag"
  type        = string
}

variable "db_host" {
  description = "RDS hostname"
  type        = string
}

variable "db_port" {
  description = "Database port"
  type        = number
}

variable "db_name" {
  description = "Application database name"
  type        = string
}

variable "db_user" {
  description = "Application database username"
  type        = string
}

variable "db_secret_arn" {
  description = "Secrets Manager ARN containing the RDS master password"
  type        = string
}

variable "redis_host" {
  description = "Valkey endpoint"
  type        = string
}

variable "redis_port" {
  description = "Valkey port"
  type        = number
}

variable "task_cpu" {
  description = "Fargate task CPU units"
  type        = string
}

variable "task_memory" {
  description = "Fargate task memory in MiB"
  type        = string
}

variable "desired_count" {
  description = "Desired number of ECS tasks"
  type        = number
}

variable "health_check_grace_period_seconds" {
  description = "ECS load balancer health check grace period"
  type        = number
}

variable "log_retention_days" {
  description = "CloudWatch log retention period"
  type        = number
}