import os
import json
import boto3
from fastapi import FastAPI, HTTPException, Request
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse
from pydantic import BaseModel
from prometheus_fastapi_instrumentator import Instrumentator
from slowapi import Limiter, _rate_limit_exceeded_handler
from slowapi.util import get_remote_address
from slowapi.errors import RateLimitExceeded

app = FastAPI(
    title="Gavin Alan - DevOps Home Lab",
    description="Deployed via Docker, GitHub Actions CI/CD, ECR and ECS.",
    version="2.0.0"
)

Instrumentator().instrument(app).expose(app)

limiter = Limiter(key_func=get_remote_address)
app.state.limiter = limiter
app.add_exception_handler(RateLimitExceeded, _rate_limit_exceeded_handler)

app.mount("/static", StaticFiles(directory="static"), name="static")
templates = Jinja2Templates(directory="templates")

AWS_REGION = os.getenv("AWS_REGION", "us-east-1")
S3_BUCKET = os.getenv("S3_BUCKET", "devops-homelab-documents")
BEDROCK_MODEL_ID = "us.anthropic.claude-haiku-4-5-20251001-v1:0"

class AskRequest(BaseModel):
    question: str

class AskResponse(BaseModel):
    question: str
    answer: str
    context_used: bool

def get_context_from_s3(question: str) -> str:
    try:
        s3 = boto3.client("s3", region_name=AWS_REGION)
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
    bedrock = boto3.client("bedrock-runtime", region_name=AWS_REGION)
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

@app.get("/", response_class=HTMLResponse)
def home(request: Request):
    return templates.TemplateResponse("home.html", {"request": request})

@app.get("/chat", response_class=HTMLResponse)
def chat_page(request: Request):
    return templates.TemplateResponse("chat.html", {"request": request})

@app.get("/api/info")
def api_info():
    return {
        "name": "Gavin Alan - DevOps Home Lab",
        "version": "2.0.0",
        "phase": os.getenv("APP_PHASE", "Phase 4: FastAPI + REST API"),
        "cloud": os.getenv("CLOUD_PROVIDER", "unknown")
    }

@app.get("/health")
def health():
    return {"status": "healthy"}

@app.post("/ask", response_model=AskResponse)
@limiter.limit("5/minute")
@limiter.limit("60/minute")
def ask(payload: AskRequest, request: Request):
    try:
        context = get_context_from_s3(payload.question)
        answer = ask_bedrock(payload.question, context)
        return AskResponse(
            question=payload.question,
            answer=answer,
            context_used=bool(context)
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
