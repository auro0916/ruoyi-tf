resource "aws_ecr_repository" "ruoyi" {
  name                 = "${var.name_prefix}-ruoyi"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.name_prefix}-ruoyi"
  }
}