variable "name_prefix" {
  description = "Prefix used for resource names"
  type        = string
}

variable "bucket_name" {
  description = "Existing S3 bucket containing the frontend files"
  type        = string
}

variable "alb_dns_name" {
  description = "ALB DNS name used as the backend CloudFront origin"
  type        = string
}