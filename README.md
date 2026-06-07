# DevOps Home Lab
End-to-end DevOps pipeline built for learning and portfolio purposes, targeting AI Cloud Engineer roles.

## Status
Phase 4 in progress — FastAPI, ECR, IAM OIDC, and Terraform modules complete. ECS and AWS Bedrock coming next.

## Stack
- **Terraform** — AWS infrastructure provisioning with reusable modules (vpc, ec2, security_group, ecr, iam)
- **Ansible** — server configuration + security hardening
- **Docker + Docker Compose** — app containerization and multi-service orchestration
- **GitHub Actions** — CI/CD pipeline (builds and pushes to ECR, deploys on every push to main)
- **AWS ECR** — private Docker image registry
- **FastAPI** — Python REST API with auto-generated Swagger docs and Pydantic validation
- **Prometheus** — metrics collection
- **Grafana** — monitoring dashboards (HTTP requests, response time, CPU, memory)

## Phases
- [x] Phase 1: Repo setup + Terraform + Ansible
- [x] Phase 2: Docker + GitHub Actions CI/CD
- [x] Phase 3: Monitoring (Prometheus + Grafana)
- [ ] Phase 4: GenAI layer (AWS Bedrock + FastAPI + ECR/ECS)
  - [x] Flask to FastAPI migration
  - [x] Terraform refactor to reusable modules
  - [x] AWS ECR — Docker image registry
  - [x] IAM OIDC — keyless GitHub Actions authentication
  - [ ] ECS — container orchestration
  - [ ] AWS Bedrock — RAG endpoint (Anthropic Claude)
  - [ ] CloudWatch — monitoring

## How it works
Every push to main triggers the CI/CD pipeline. GitHub Actions authenticates to AWS via OIDC (no stored credentials), builds the Docker image, pushes it to ECR, then deploys to EC2 by pulling the latest image from ECR — zero manual steps.

## Live Endpoints
- App: http://107.21.212.161
- Swagger Docs: http://107.21.212.161/docs
- Grafana: http://107.21.212.161:3000
- Prometheus: http://107.21.212.161:9090
- Metrics: http://107.21.212.161/metrics

## Monitoring Dashboard
![Grafana Dashboard](images/grafana-dashboard.png)
