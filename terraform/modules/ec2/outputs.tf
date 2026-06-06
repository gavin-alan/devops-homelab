output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.main.id
}

output "public_ip" {
  description = "Elastic IP of the EC2 instance"
  value       = aws_eip.main.public_ip
}
