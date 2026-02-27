# EKS Frontend → Local Backend (Private) via NGINX Ingress + Endpoints

## What this does
Kubernetes cannot reach your laptop via `localhost`.
This setup routes `/api/*` from NGINX Ingress to a local backend by creating:
- a Service with no selector
- an Endpoints object pointing to your laptop IP/port

This requires your laptop IP to be routable from EKS (commonly via an AWS Site VPN to connect to that cluster).

---

## 1) Run backend locally (bind to 0.0.0.0)
Backend must listen on all interfaces.

Test:
```bash
curl -i http://localhost:8080/health
