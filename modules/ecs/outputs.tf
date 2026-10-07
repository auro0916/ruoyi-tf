output "cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.lab.name
}

output "service_name" {
  description = "ECS service name"
  value       = aws_ecs_service.ruoyi.name
}

output "task_definition_arn" {
  description = "ECS task definition ARN"
  value       = aws_ecs_task_definition.ruoyi.arn
}

output "log_group_name" {
  description = "CloudWatch log group name"
  value       = aws_cloudwatch_log_group.ruoyi.name
}