aws_region  = "ap-northeast-1"
name_prefix = "ruoyi-stg"

vpc_cidr = "10.100.0.0/16"

public_subnet_a_cidr = "10.100.1.0/24"
public_subnet_c_cidr = "10.100.2.0/24"

az_a = "ap-northeast-1a"
az_c = "ap-northeast-1c"

private_subnets = {
  a = {
    cidr = "10.100.11.0/24"
    az   = "ap-northeast-1a"
  }

  c = {
    cidr = "10.100.12.0/24"
    az   = "ap-northeast-1c"
  }
}

db_subnets = {
  a = {
    cidr = "10.100.21.0/24"
    az   = "ap-northeast-1a"
  }

  c = {
    cidr = "10.100.22.0/24"
    az   = "ap-northeast-1c"
  }
}

bastion_ami_id        = "ami-06380d26ad7176f2c"
bastion_instance_type = "t3.micro"
ec2_key_name          = "ry-ec2"

rds_snapshot_identifier     = "ruoyi-before-refactor"
rds_instance_class          = "db.t3.micro"
rds_backup_retention_period = 1

db_name = "ry-vue"
db_user = "admin"

redis_node_type = "cache.t4g.micro"

alb_health_check_path = "/"

image_tag = "bootstrap"

ecs_desired_count                     = 0
ecs_task_cpu                          = "512"
ecs_task_memory                       = "1024"
ecs_health_check_grace_period_seconds = 150

cloudwatch_log_retention_days = 7

frontend_bucket_name = "ry-stg-v1"