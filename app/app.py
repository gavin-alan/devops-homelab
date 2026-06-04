from flask import Flask
from prometheus_flask_exporter import PrometheusMetrics

app = Flask(__name__)
metrics = PrometheusMetrics(app)

@app.route('/')
def home():
    return '<h1>Gavin Alan - DevOps Home Lab</h1><p>Deployed via Docker and GitHub Actions CI/CD pipeline.</p><p>Phase 3: Monitoring with Prometheus + Grafana.</p>'

@app.route('/health')
def health():
    return {'status': 'healthy'}, 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
