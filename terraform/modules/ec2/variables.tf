variable "project_name" {
  description = "Project name used for tagging"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "ID of the subnet to launch into"
  type        = string
}

variable "security_group_id" {
  description = "ID of the security group"
  type        = string
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key"
  type        = string
}

variable "instance_profile_name" {
  description = "Name of the IAM instance profile to attach"
  type        = string
}
