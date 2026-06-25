output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "subnet_id_b" {
  description = "ID of the second public subnet (for ALB multi-AZ)"
  value       = aws_subnet.public_b.id
}
