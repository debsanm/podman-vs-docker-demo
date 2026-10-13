#!/usr/bin/env bash
# Demo 2: Podman pods + Kubernetes YAML export/replay.
set -euo pipefail

command -v podman >/dev/null 2>&1 || { echo "Error: 'podman' is not installed." >&2; exit 1; }

cd "$(dirname "$0")"
cleanup() { podman pod rm -f web >/dev/null 2>&1 || true; }
trap cleanup EXIT
cleanup   # start clean in case an old pod exists

echo "==> 1. Create a pod and add containers"
podman pod create --name web -p 8080:80
podman run -d --pod web --name web-nginx docker.io/library/nginx
podman run -d --pod web --name web-redis docker.io/library/redis
podman pod ps

echo "==> 2. Export Kubernetes YAML"
podman generate kube web > web.yaml
echo "Saved web.yaml (first lines):"
head -n 15 web.yaml

echo "==> 3. Replay it anywhere"
podman pod rm -f web
podman kube play web.yaml
podman pod ps

if [ -t 0 ]; then
  read -r -p "Open http://localhost:8080 now. Press Enter to clean up... " _
fi
