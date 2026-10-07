module "network" {
  source = "../../modules/network"

  name_prefix = var.name_prefix

  vpc_cidr = var.vpc_cidr

  public_subnet_a_cidr = var.public_subnet_a_cidr
  public_subnet_c_cidr = var.public_subnet_c_cidr

  az_a = var.az_a
  az_c = var.az_c

  private_subnets = var.private_subnets
  db_subnets      = var.db_subnets
}

module "security" {
  source = "../../modules/security"

  name_prefix = var.name_prefix
  vpc_id      = module.network.vpc_id
}

module "bastion" {
  source = "../../modules/bastion"

  name_prefix      = var.name_prefix
  ami_id           = var.bastion_ami_id
  instance_type    = var.bastion_instance_type
  key_name         = var.ec2_key_name
  public_subnet_id = module.network.public_subnet_ids[0]
  ec2_sg_id        = module.security.ec2_sg_id
}

module "database" {
  source = "../../modules/database"

  name_prefix = var.name_prefix

  db_subnet_ids = values(module.network.db_subnet_ids)
  rds_sg_id     = module.security.rds_sg_id

  snapshot_identifier = var.rds_snapshot_identifier
  instance_class      = var.rds_instance_class

  backup_retention_period = var.rds_backup_retention_period
}

module "cache" {
  source = "../../modules/cache"

  name_prefix        = var.name_prefix
  private_subnet_ids = values(module.network.private_subnet_ids)
  redis_sg_id        = module.security.redis_sg_id
  node_type          = var.redis_node_type
}

module "ecr" {
  source = "../../modules/ecr"

  name_prefix = var.name_prefix
}

module "alb" {
  source = "../../modules/alb"

  name_prefix       = var.name_prefix
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
  alb_sg_id         = module.security.alb_sg_id
  health_check_path = var.alb_health_check_path
}

module "ecs" {
  source = "../../modules/ecs"

  name_prefix = var.name_prefix
  aws_region  = var.aws_region

  private_subnet_ids = values(module.network.private_subnet_ids)
  app_sg_id          = module.security.app_sg_id
  target_group_arn   = module.alb.target_group_arn

  ecr_repository_url = module.ecr.repository_url
  image_tag          = var.image_tag

  db_host       = module.database.address
  db_port       = 3306
  db_name       = var.db_name
  db_user       = var.db_user
  db_secret_arn = module.database.master_secret_arn

  redis_host = module.cache.primary_endpoint_address
  redis_port = module.cache.port

  task_cpu                          = var.ecs_task_cpu
  task_memory                       = var.ecs_task_memory
  desired_count                     = var.ecs_desired_count
  health_check_grace_period_seconds = var.ecs_health_check_grace_period_seconds
  log_retention_days                = var.cloudwatch_log_retention_days
}

module "frontend" {
  source = "../../modules/frontend"

  name_prefix  = var.name_prefix
  bucket_name  = var.frontend_bucket_name
  alb_dns_name = module.alb.alb_dns_name
}