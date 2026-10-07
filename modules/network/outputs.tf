output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.lab.id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value = [
    aws_subnet.public_a.id,
    aws_subnet.public_c.id
  ]
}

output "private_subnet_ids" {
  description = "Private application subnet IDs"
  value = {
    for key, subnet in aws_subnet.private :
    key => subnet.id
  }
}

output "db_subnet_ids" {
  description = "Private database subnet IDs"
  value = {
    for key, subnet in aws_subnet.db :
    key => subnet.id
  }
}

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = aws_nat_gateway.lab.id
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.lab.id
}