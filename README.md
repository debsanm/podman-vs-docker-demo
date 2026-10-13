# Podman vs Docker: Demo Code

Hands-on examples that go with the YouTube video **Podman vs Docker**.
Each folder is one demo. Every script cleans up after itself.

## What's inside

| Folder | What it shows |
|---|---|
| `01-same-commands/` | The same commands on Docker and Podman |
| `02-pods-kubernetes/` | Pods, plus exporting and replaying Kubernetes YAML (Podman) |
| `03-quadlet-systemd/` | Running a container as a systemd service (Podman, Linux) |
| `04-compose/` | One `compose.yaml` on both tools |
| `slides/` | The presentation used in the video |

## Requirements

- **Docker** and/or **Podman** installed
- Demo 3 needs Linux with systemd and Podman 4.4 or newer
- Demo 4 with Podman needs `docker-compose` or `podman-compose` installed

## Quick start

```bash
git clone <your-repo-url>
cd podman-vs-docker-demo
chmod +x */*.sh cleanup.sh

# Demo 1: pick an engine
./01-same-commands/run.sh podman
./01-same-commands/run.sh docker

# Demo 2: pods and Kubernetes YAML
./02-pods-kubernetes/run.sh

# Demo 3: systemd service with Quadlet
./03-quadlet-systemd/install.sh
./03-quadlet-systemd/uninstall.sh

# Demo 4: compose
./04-compose/run.sh podman
./04-compose/run.sh docker
```

Then open <http://localhost:8080> to see nginx running.

## Handy tip

Make Podman act like Docker for your old habits and scripts:

```bash
alias docker=podman
```

## Good to know

- All demos use **port 8080**. Run one demo at a time, or run `./cleanup.sh` between demos.
- Images use full names such as `docker.io/library/nginx` so Podman does not ask which registry to use.
- Demo 3 does not work on macOS or Windows because it needs systemd.

## Cleanup

```bash
./cleanup.sh
```

## License

MIT. See [LICENSE](LICENSE).
