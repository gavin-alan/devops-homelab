# DevOps Home Lab

End-to-end DevOps pipeline built for learning and portfolio purposes.

## Status
Phase 2 complete. Phase 3 in progress — Monitoring (Prometheus + Grafana).

## Stack
- **Terraform** — AWS infrastructure provisioning
- **Ansible** — server configuration + security hardening
- **Docker** — app containerization
- **GitHub Actions** — CI/CD pipeline (auto-deploys on every push to main)

## Phases
- [x] Phase 1: Repo setup + Terraform + Ansible
- [x] Phase 2: Docker + GitHub Actions CI/CD
- [ ] Phase 3: Monitoring (Prometheus + Grafana)
- [ ] Phase 4: GenAI layer (AWS Bedrock + FastAPI + ECR/ECS)

## How it works
Every push to main automatically triggers the CI/CD pipeline which pulls the latest code, rebuilds the Docker image, and redeploys the container to AWS EC2 — zero manual steps.
