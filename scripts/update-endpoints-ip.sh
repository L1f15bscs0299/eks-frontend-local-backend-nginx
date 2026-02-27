#!/usr/bin/env bash
set -euo pipefail

NS="${1:-default}"
NEW_IP="${2:?Usage: $0 [namespace] <NEW_IP> [PORT]}"
PORT="${3:-8080}"

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Endpoints
metadata:
  name: backend-local
  namespace: ${NS}
subsets:
  - addresses:
      - ip: ${NEW_IP}
    ports:
      - name: http
        port: ${PORT}
        protocol: TCP
EOF

echo "Updated backend-local endpoints to ${NEW_IP}:${PORT} in namespace ${NS}"
