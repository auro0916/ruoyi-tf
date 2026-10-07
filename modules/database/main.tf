resource "aws_db_subnet_group" "lab" {
  name       = "${var.name_prefix}-db-subnet-group"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "${var.name_prefix}-db-subnet-group"
  }
}

resource "aws_db_instance" "mysql" {
  identifier = "${var.name_prefix}-mysql"

  snapshot_identifier = var.snapshot_identifier

  instance_class = var.instance_class

  db_subnet_group_name   = aws_db_subnet_group.lab.name
  vpc_security_group_ids = [var.rds_sg_id]

  publicly_accessible = false
  multi_az            = false
  storage_encrypted = true
  backup_retention_period = var.backup_retention_period
  skip_final_snapshot       = true

  manage_master_user_password = true

  tags = {
    Name = "${var.name_prefix}-mysql"
  }
}