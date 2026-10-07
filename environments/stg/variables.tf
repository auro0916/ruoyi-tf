variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "name_prefix" {
  description = "Prefix used for STG resource names"
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

variable "bastion_ami_id" {
  description = "AMI ID for the bastion EC2 instance"
  type        = string
}

variable "bastion_instance_type" {
  description = "Bastion EC2 instance type"
  type        = string
}

variable "ec2_key_name" {
  description = "AWS EC2 key pair name"
  type        = string
}

variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "rds_backup_retention_period" {
  description = "RDS backup retention period in days"
  type        = number
}

variable "db_name" {
  description = "RuoYi application database name"
  type        = string
}

variable "db_user" {
  description = "RDS master/application username"
  type        = string
}

variable "redis_node_type" {
  description = "ElastiCache node type"
  type        = string
}

variable "alb_health_check_path" {
  description = "ALB target group health check path"
  type        = string
}

variable "image_tag" {
  description = "Backend image tag in ECR"
  type        = string
}

variable "ecs_task_cpu" {
  description = "Fargate task CPU units"
  type        = string
}

variable "ecs_task_memory" {
  description = "Fargate task memory in MiB"
  type        = string
}

variable "ecs_desired_count" {
  description = "Desired number of ECS tasks"
  type        = number
}

variable "ecs_health_check_grace_period_seconds" {
  description = "ECS health check grace period in seconds"
  type        = number
}

variable "cloudwatch_log_retention_days" {
  description = "CloudWatch log retention period in days"
  type        = number
}

variable "frontend_bucket_name" {
  description = "Existing S3 bucket containing the frontend build"
  type        = string
}

variable "rds_snapshot_identifier" {
  description = "RDS snapshot used to restore the STG database"
  type        = string
}