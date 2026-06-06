from fastapi import FastAPI
from prometheus_fastapi_instrumentator import Instrumentator

app = FastAPI(
    title="Gavin Alan - DevOps Home Lab",
    description="Deployed via Docker, GitHub Actions CI/CD, ECR and ECS.",
    version="2.0.0"
)

Instrumentator().instrument(app).expose(app)

@app.get("/")
def home():
    return {
        "name": "Gavin Alan - DevOps Home Lab",
        "version": "2.0.0",
        "phase": "Phase 4: FastAPI + AWS Bedrock + ECR/ECS"
    }

@app.get("/health")
def health():
    return {"status": "healthy"}
