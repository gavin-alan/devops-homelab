variable "project_name" {
  description = "Project name used for tagging"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_cidr_b" {
  description = "CIDR block for second public subnet (required for ALB multi-AZ)"
  type        = string
  default     = "10.0.2.0/24"
}

variable "availability_zone_a" {
  description = "AZ for primary subnet"
  type        = string
  default     = "us-east-1d"
}

variable "availability_zone_b" {
  description = "AZ for second public subnet"
  type        = string
  default     = "us-east-1c"
}
