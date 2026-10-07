output "primary_endpoint_address" {
  description = "Valkey primary endpoint"
  value       = aws_elasticache_replication_group.redis.primary_endpoint_address
}

output "port" {
  description = "Valkey port"
  value       = aws_elasticache_replication_group.redis.port
}