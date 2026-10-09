variable "aws_region" {
  description = "AWS region to deploy into"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "project_name" {
  description = "Project name used for tagging"
  default     = "devops-homelab"
}

variable "monthly_budget_usd" {
  description = "Monthly AWS cost budget in USD; an email alert is sent at 80% of actual spend"
  type        = number
  default     = 1
}

variable "my_ip" {
  description = "Public IPv4 address allowed to SSH, without /32"
  type        = string
}
