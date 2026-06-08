terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
}

module "security_group" {
  source       = "./modules/security_group"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}

module "s3" {
  source       = "./modules/s3"
  project_name = var.project_name
}

module "iam" {
  source        = "./modules/iam"
  project_name  = var.project_name
  github_repo   = "gavin-alan/devops-homelab"
  s3_bucket_arn = module.s3.bucket_arn
}

module "ec2" {
  source                = "./modules/ec2"
  project_name          = var.project_name
  instance_type         = var.instance_type
  subnet_id             = module.vpc.subnet_id
  security_group_id     = module.security_group.security_group_id
  ssh_public_key_path   = "~/.ssh/devops-homelab.pub"
  instance_profile_name = module.iam.ec2_instance_profile_name
}

module "ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
}

module "ecs" {
  source                  = "./modules/ecs"
  project_name            = var.project_name
  aws_region              = var.aws_region
  ecr_repository_url      = module.ecr.repository_url
  task_execution_role_arn = module.iam.ecs_task_execution_role_arn
  task_role_arn           = module.iam.ecs_task_role_arn
  subnet_id               = module.vpc.subnet_id
  security_group_id       = module.security_group.security_group_id
}

module "cloudwatch" {
  source       = "./modules/cloudwatch"
  project_name = var.project_name
  alarm_email  = "cloud01@gavinalan.com"
}
