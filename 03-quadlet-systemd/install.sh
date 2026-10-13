#!/usr/bin/env bash
# Demo 3: run a container as a systemd user service with Quadlet.
# Needs Linux + systemd + Podman 4.4 or newer.
set -euo pipefail

[ "$(uname -s)" = "Linux" ] || { echo "Error: Quadlet only works on Linux with systemd." >&2; exit 1; }
command -v podman >/dev/null 2>&1 || { echo "Error: 'podman' is not installed." >&2; exit 1; }

DEST="${XDG_CONFIG_HOME:-$HOME/.config}/containers/systemd"
mkdir -p "$DEST"
cp "$(dirname "$0")/web.container" "$DEST/web.container"
echo "==> Copied web.container to $DEST"

systemctl --user daemon-reload
systemctl --user start web.service
systemctl --user status web.service --no-pager || true

echo
echo "Open http://localhost:8080"
echo "Logs:    journalctl --user -u web"
echo "Cleanup: ./uninstall.sh"
