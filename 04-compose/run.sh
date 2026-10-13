#!/usr/bin/env bash
# Demo 4: the same compose.yaml works with both tools.
# Usage: ./run.sh [docker|podman]   (default: podman)
# Note: 'podman compose' needs docker-compose or podman-compose installed.
set -euo pipefail

ENGINE="${1:-podman}"
command -v "$ENGINE" >/dev/null 2>&1 || { echo "Error: '$ENGINE' is not installed." >&2; exit 1; }

cd "$(dirname "$0")"
cleanup() { "$ENGINE" compose down >/dev/null 2>&1 || true; }
trap cleanup EXIT

echo "==> $ENGINE compose up -d"
"$ENGINE" compose up -d
"$ENGINE" compose ps

if [ -t 0 ]; then
  read -r -p "Open http://localhost:8080 now. Press Enter to run 'compose down'... " _
fi
