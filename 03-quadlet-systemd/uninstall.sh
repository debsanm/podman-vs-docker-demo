#!/usr/bin/env bash
# Stops and removes the Quadlet demo service.
set -euo pipefail

DEST="${XDG_CONFIG_HOME:-$HOME/.config}/containers/systemd"
systemctl --user stop web.service 2>/dev/null || true
rm -f "$DEST/web.container"
systemctl --user daemon-reload
echo "Removed web.service"
