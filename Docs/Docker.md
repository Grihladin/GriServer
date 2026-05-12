Related: [[GriServer]]

## Docker

Installed from Docker's official apt repository.

```text
Docker Engine 29.4.3
Docker Compose plugin v5.1.3
```

The main user is in the `docker` group, so Docker can be used without sudo

Important: users in the `docker` group effectively have root-level control on the server.

## Log Rotation

Configured in `/etc/docker/daemon.json`:

```json
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "5"
  }
}
```

This caps each container at about 50 MB of Docker logs.
