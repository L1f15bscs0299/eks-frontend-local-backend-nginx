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

Troubleshooting

If curl from the cluster to <LAPTOP_IP>:8080 fails, the cluster cannot reach your laptop IP (routing/firewall/VPN).

Ensure backend binds to 0.0.0.0, not 127.0.0.1.

If your laptop IP changes, update Endpoints:

./scripts/update-endpoints-ip.sh default <NEW_IP> 8080


---

## The one thing that can still “cause errors”
Your laptop IP can change (DHCP/VPN). If it changes, update the Endpoints (script included). That’s the tradeoff of “no tunnels and no infra.”

If you tell me your backend port and your frontend domain path (do you want `/api` or `/backend`?), I’ll tailor the YAMLs exactly to your case.
