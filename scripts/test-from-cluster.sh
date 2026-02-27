#!/usr/bin/env bash
set -euo pipefail

IP="${1:?Usage: $0 <LAPTOP_IP> [PORT]}"
PORT="${2:-8080}"

kubectl run -it --rm curl --image=curlimages/curl -- sh -c "curl -i --max-time 5 http://${IP}:${PORT}/health"
