output "vpc_id" {
  description = "STG VPC ID"
  value       = module.network.vpc_id
}

output "bastion_public_ip" {
  description = "Bastion public IP"
  value       = module.bastion.public_ip
}

output "rds_endpoint" {
  description = "RDS endpoint"
  value       = module.database.endpoint
}

output "redis_endpoint" {
  description = "Valkey primary endpoint"
  value       = module.cache.primary_endpoint_address
}

output "ecr_repository_url" {
  description = "Backend ECR repository URL"
  value       = module.ecr.repository_url
}

output "alb_dns_name" {
  description = "ALB DNS name"
  value       = module.alb.alb_dns_name
}

output "cloudfront_domain_name" {
  description = "CloudFront domain name"
  value       = module.frontend.cloudfront_domain_name
}