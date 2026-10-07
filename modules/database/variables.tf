variable "name_prefix" {
  description = "Prefix used for resource names"
  type        = string
}

variable "db_subnet_ids" {
  description = "Database subnet IDs"
  type        = list(string)
}

variable "rds_sg_id" {
  description = "RDS security group ID"
  type        = string
}

variable "snapshot_identifier" {
  description = "RDS snapshot identifier used to restore the database"
  type        = string
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
}