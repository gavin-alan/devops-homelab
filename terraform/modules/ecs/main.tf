resource "aws_cloudwatch_log_group" "app" {
  name              = "/ecs/${var.project_name}"
  retention_in_days = 7
  tags = {
    Project = var.project_name
  }
}

resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-cluster"
  tags = {
    Project = var.project_name
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = "${var.project_name}-task"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.task_execution_role_arn
  task_role_arn            = var.task_role_arn

  container_definitions = jsonencode([{
    name      = "${var.project_name}-container"
    image     = "${var.ecr_repository_url}:latest"
    essential = true

    environment = [
      {
        name  = "CLOUD_PROVIDER"
        value = "AWS"
      },
      {
        name  = "APP_PHASE"
        value = "Phase 4: FastAPI + AWS Bedrock + ECR/ECS"
      }
    ]

    portMappings = [{
      containerPort = 8000
      hostPort      = 80
      protocol      = "tcp"
    }]

    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-group"         = "/ecs/${var.project_name}"
        "awslogs-region"        = var.aws_region
        "awslogs-stream-prefix" = "ecs"
      }
    }

    healthCheck = {
      command     = ["CMD-SHELL", "curl -f http://localhost:8000/health || exit 1"]
      interval    = 30
      timeout     = 5
      retries     = 3
      startPeriod = 10
    }
  }])
}

resource "aws_ecs_service" "app" {
  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "EC2"
  tags = {
    Project = var.project_name
  }
}
