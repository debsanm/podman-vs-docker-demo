#!/usr/bin/env bash
# Demo 1: the same commands work on Docker and Podman.
# Usage: ./run.sh [docker|podman]   (default: podman)
set -euo pipefail

ENGINE="${1:-podman}"
command -v "$ENGINE" >/dev/null 2>&1 || { echo "Error: '$ENGINE' is not installed." >&2; exit 1; }

cleanup() { "$ENGINE" rm -f demo-nginx >/dev/null 2>&1 || true; }
trap cleanup EXIT

cd "$(dirname "$0")"
echo "==> Using: $ENGINE"

echo "==> run: start nginx on http://localhost:8080"
"$ENGINE" run -d --name demo-nginx -p 8080:80 docker.io/library/nginx

echo "==> ps: list running containers"
"$ENGINE" ps

echo "==> pull: download alpine"
"$ENGINE" pull docker.io/library/alpine

echo "==> build: build our own image"
"$ENGINE" build -t myapp .

echo "==> run: start our image"
"$ENGINE" run --rm myapp

echo "==> images: list images"
"$ENGINE" images

if [ -t 0 ]; then
  read -r -p "Open http://localhost:8080 now. Press Enter to clean up... " _
fi
