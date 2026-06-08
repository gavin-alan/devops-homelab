# DevOps Home Lab
End-to-end DevOps pipeline built for learning and portfolio purposes, targeting AI Cloud Engineer roles.

## Status
Phase 4 complete.

## Stack
- **Terraform** — AWS infrastructure provisioning with reusable modules (vpc, ec2, security_group, ecr, iam, ecs, s3, cloudwatch)
- **Ansible** — server configuration + security hardening
- **Docker** — app containerization
- **GitHub Actions** — CI/CD pipeline (builds image, pushes to ECR, deploys to ECS via OIDC — no stored AWS credentials)
- **AWS ECR** — private Docker image registry
- **AWS ECS** — container orchestration (EC2 launch type)
- **AWS Bedrock** — Claude Haiku 4.5 AI endpoint with RAG pattern over S3 documents
- **AWS S3** — document storage for RAG pattern
- **AWS CloudWatch** — ECS metrics, log aggregation, CPU/memory/task alarms via SNS
- **FastAPI** — Python REST API with auto-generated Swagger docs and Pydantic validation
- **Prometheus** — metrics collection
- **Grafana** — monitoring dashboards (HTTP requests, response time, CPU, memory)

## Phases
- [x] Phase 1: Repo setup + Terraform + Ansible
- [x] Phase 2: Docker + GitHub Actions CI/CD
- [x] Phase 3: Monitoring (Prometheus + Grafana)
- [x] Phase 4: GenAI layer (AWS Bedrock + FastAPI + ECR/ECS)
  - [x] Flask to FastAPI migration
  - [x] Terraform refactor to reusable modules
  - [x] AWS ECR — Docker image registry
  - [x] IAM OIDC — keyless GitHub Actions authentication
  - [x] AWS ECS — container orchestration
  - [x] AWS Bedrock — RAG endpoint (Claude Haiku 4.5)
  - [x] AWS CloudWatch — alarms and log aggregation

## How it works
Every push to main triggers the CI/CD pipeline. GitHub Actions authenticates to AWS via OIDC (no stored credentials), builds the Docker image, pushes it to ECR, then triggers an ECS service update — ECS pulls the latest image and redeploys automatically. The monitoring stack (Prometheus, Grafana, Node Exporter) is managed separately via Docker Compose on the same instance.

## API Endpoints
- **GET /** — App info
- **GET /health** — Health check (used by ECS)
- **GET /metrics** — Prometheus metrics
- **POST /ask** — AI endpoint (AWS Bedrock + Claude Haiku 4.5)
- **GET /docs** — Swagger UI

## Live Endpoints
- App: http://107.21.212.161
- Swagger Docs: http://107.21.212.161/docs
- Grafana: http://107.21.212.161:3000
- Prometheus: http://107.21.212.161:9090
- Metrics: http://107.21.212.161/metrics

## Monitoring Dashboard
![Grafana Dashboard](images/grafana-dashboard.png)
