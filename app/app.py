import os
import json
import boto3
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from prometheus_fastapi_instrumentator import Instrumentator

app = FastAPI(
    title="Gavin Alan - DevOps Home Lab",
    description="Deployed via Docker, GitHub Actions CI/CD, ECR and ECS.",
    version="2.0.0"
)

Instrumentator().instrument(app).expose(app)

AWS_REGION = os.getenv("AWS_REGION", "us-east-1")
S3_BUCKET = os.getenv("S3_BUCKET", "devops-homelab-documents")
BEDROCK_MODEL_ID = "anthropic.claude-3-haiku-20240307-v1:0"

bedrock = boto3.client("bedrock-runtime", region_name=AWS_REGION)
s3 = boto3.client("s3", region_name=AWS_REGION)

class AskRequest(BaseModel):
    question: str

class AskResponse(BaseModel):
    question: str
    answer: str
    context_used: bool

def get_context_from_s3(question: str) -> str:
    try:
        response = s3.list_objects_v2(Bucket=S3_BUCKET)
        if "Contents" not in response:
            return ""
        context_parts = []
        for obj in response["Contents"][:3]:
            doc = s3.get_object(Bucket=S3_BUCKET, Key=obj["Key"])
            content = doc["Body"].read().decode("utf-8")
            context_parts.append(f"Document: {obj['Key']}\n{content}")
        return "\n\n".join(context_parts)
    except Exception:
        return ""

def ask_bedrock(question: str, context: str) -> str:
    if context:
        prompt = f"Use the following documents to answer the question.\n\nDocuments:\n{context}\n\nQuestion: {question}"
    else:
        prompt = question

    body = json.dumps({
        "anthropic_version": "bedrock-2023-05-31",
        "max_tokens": 1000,
        "messages": [{"role": "user", "content": prompt}]
    })

    response = bedrock.invoke_model(
        modelId=BEDROCK_MODEL_ID,
        body=body
    )

    result = json.loads(response["body"].read())
    return result["content"][0]["text"]

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

@app.post("/ask", response_model=AskResponse)
def ask(request: AskRequest):
    try:
        context = get_context_from_s3(request.question)
        answer = ask_bedrock(request.question, context)
        return AskResponse(
            question=request.question,
            answer=answer,
            context_used=bool(context)
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
