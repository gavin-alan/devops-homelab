resource "aws_budgets_budget" "cost_guard" {
  name         = "${var.project_name}-cost-guard"
  budget_type  = "COST"
  limit_amount = tostring(var.monthly_budget_usd)
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  notification {
    notification_type          = "ACTUAL"
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    subscriber_email_addresses = [var.alert_email]
  }

  tags = {
    Name    = "${var.project_name}-cost-guard"
    Project = var.project_name
  }
}
