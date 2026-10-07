resource "aws_elasticache_subnet_group" "lab" {
  name       = "${var.name_prefix}-redis-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.name_prefix}-redis-subnet-group"
  }
}

resource "aws_elasticache_replication_group" "redis" {
  replication_group_id = "${var.name_prefix}-redis"
  description          = "${var.name_prefix} Valkey"

  engine    = "valkey"
  node_type = var.node_type

  num_cache_clusters = 1

  subnet_group_name  = aws_elasticache_subnet_group.lab.name
  security_group_ids = [var.redis_sg_id]

  port = 6379

  automatic_failover_enabled = false
  multi_az_enabled           = false

  tags = {
    Name = "${var.name_prefix}-redis"
  }
}