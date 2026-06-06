output "instance_public_ip" {
  description = "Elastic IP of the EC2 instance"
  value       = module.ec2.public_ip
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = module.ec2.instance_id
}
