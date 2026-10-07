output "alb_arn" {
  description = "ALB ARN"
  value       = aws_lb.ruoyi.arn
}

output "alb_dns_name" {
  description = "ALB DNS name"
  value       = aws_lb.ruoyi.dns_name
}

output "target_group_arn" {
  description = "ALB target group ARN"
  value       = aws_lb_target_group.ruoyi.arn
}