output "address" {
  description = "RDS hostname"
  value       = aws_db_instance.mysql.address
}

output "endpoint" {
  description = "RDS endpoint including port"
  value       = aws_db_instance.mysql.endpoint
}

output "port" {
  description = "RDS port"
  value       = aws_db_instance.mysql.port
}

output "master_secret_arn" {
  description = "Secrets Manager ARN containing the RDS master credentials"
  value       = aws_db_instance.mysql.master_user_secret[0].secret_arn
}