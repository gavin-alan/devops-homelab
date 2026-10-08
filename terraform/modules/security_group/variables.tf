variable "project_name" {
  description = "Project name used for tagging"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "my_ip" {
  description = "Public IPv4 address allowed to SSH, without /32"
  type        = string
}
