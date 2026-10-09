variable "project_name" {
  description = "Project name used for tagging"
  type        = string
}

variable "monthly_budget_usd" {
  description = "Monthly cost budget in USD; alerts at 80% of actual spend"
  type        = number
}

variable "alert_email" {
  description = "Email address for budget notifications"
  type        = string
}
