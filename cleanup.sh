#!/usr/bin/env bash
# Best-effort cleanup of everything the demos create.
cd "$(dirname "$0")" || exit 1
docker rm -f demo-nginx 2>/dev/null
podman rm -f demo-nginx 2>/dev/null
podman pod rm -f web 2>/dev/null
(cd 04-compose && { docker compose down; podman compose down; }) 2>/dev/null
if [ "$(uname -s)" = "Linux" ]; then ./03-quadlet-systemd/uninstall.sh 2>/dev/null; fi
rm -f 02-pods-kubernetes/web.yaml
echo "Cleanup finished."
exit 0
