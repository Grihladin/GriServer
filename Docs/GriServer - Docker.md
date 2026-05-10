Related: [[GriServer]]

## Installation

Docker was installed from Docker's official apt repository.

Installed:

```text
Docker Engine 29.4.3
Docker Compose plugin v5.1.3
```

Verified with:

```bash
sudo docker run --rm hello-world
```

The user `grihladin` was added to the `docker` group. After reconnecting with SSH, Docker can be used without sudo:

```bash
docker ps
docker compose version
```

Important: users in the `docker` group effectively have root-level control on the server.

## Log Rotation

Docker daemon log rotation was configured in:

```text
/etc/docker/daemon.json
```

Current config:

```json
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "5"
  }
}
```

This limits each container to about 50 MB of Docker logs: 5 files x 10 MB.
