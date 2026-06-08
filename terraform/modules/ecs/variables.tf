variable "project_name" {
  description = "Project name used for tagging"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "ecr_repository_url" {
  description = "ECR repository URL"
  type        = string
}

variable "task_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  type        = string
}

variable "task_role_arn" {
  description = "ARN of the ECS task role"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for ECS service"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for ECS service"
  type        = string
}
