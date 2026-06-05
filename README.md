# DevOps Home Lab

End-to-end DevOps pipeline built for learning and portfolio purposes.

## Status
Phase 3 complete. Phase 4 coming — GenAI layer (AWS Bedrock + FastAPI + ECR/ECS).

## Stack
- **Terraform** — AWS infrastructure provisioning
- **Ansible** — server configuration + security hardening
- **Docker + Docker Compose** — app containerization and multi-service orchestration
- **GitHub Actions** — CI/CD pipeline (auto-deploys on every push to main)
- **Prometheus** — metrics collection
- **Grafana** — monitoring dashboards (HTTP requests, response time, CPU, memory)

## Phases
- [x] Phase 1: Repo setup + Terraform + Ansible
- [x] Phase 2: Docker + GitHub Actions CI/CD
- [x] Phase 3: Monitoring (Prometheus + Grafana)
- [ ] Phase 4: GenAI layer (AWS Bedrock + FastAPI + ECR/ECS)

## How it works
Every push to main automatically triggers the CI/CD pipeline which pulls the latest code, rebuilds the Docker image, and redeploys the full stack via Docker Compose — zero manual steps.

## Monitoring
- Grafana dashboard: http://107.21.212.161:3000
- Prometheus: http://107.21.212.161:9090
- App metrics endpoint: http://107.21.212.161/metrics
