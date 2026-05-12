# Manifest

Manifest is a self-hosted alternative to Linear, GitHub Issues, and Notion.

## URLs

```text
https://manifest.griserver.com
```

## Stack

Compose directory:

```text
/home/grihladin/GriServer_prod/manifest
```

Containers:

```text
mnfst-manifest-1   Manifest application
mnfst-postgres-1   PostgreSQL database
```

## Architecture

Traffic flow:

```text
Cloudflare (SSL termination) -> Nginx Proxy Manager (port 80) -> Manifest (HTTP :2099)
```

### Cloudflare

SSL is terminated at Cloudflare. Requests arrive at NPM on port 80.

### Nginx Proxy Manager

NPM proxies `manifest.griserver.com` to the `manifest` service container on port 2099 via HTTP.

Proxy config is stored in:

```text
/home/grihladin/GriServer_prod/nginx-proxy-manager/data/nginx/proxy_host/3.conf
```

### Manifest

The Manifest container runs on port 2099 inside Docker. It's connected to three networks:

- `internal` - PostgreSQL only (isolated)
- `frontend` - general frontend access
- `nginx-proxy-manager_default` - for NPM proxy access

## Configuration

Environment variables are read from:

```text
/home/grihladin/GriServer_prod/manifest/.env
```

Key variables:

```text
PORT                    Application port (default 2099)
BETTER_AUTH_SECRET      Session signing secret (required)
DATABASE_URL            PostgreSQL connection string
POSTGRES_PASSWORD       PostgreSQL password
BETTER_AUTH_URL         Public URL for OAuth callbacks
OLLAMA_HOST             Local LLM server (default http://host.docker.internal:11434)
MANIFEST_MODE           Set to "selfhosted" for self-hosted semantics
```

For a fresh install, visit:

```text
http://manifest.griserver.com/setup
```

## Commands

Start or apply changes:

```bash
cd /home/grihladin/GriServer_prod/manifest
docker compose up -d
```

Restart:

```bash
cd /home/grihladin/GriServer_prod/manifest
docker compose restart
```

Repull and recreate:

```bash
cd /home/grihladin/GriServer_prod/manifest
docker compose pull
docker compose up -d --force-recreate
```

Check logs:

```bash
docker logs --tail 100 mnfst-manifest-1
docker logs --tail 100 mnfst-postgres-1
```

Verify routing:

```bash
curl -I https://manifest.griserver.com
docker exec nginx-proxy-manager curl -I http://manifest:2099
```

## Database

PostgreSQL 16 Alpine. Data persists via Docker volume `manifest_pgdata`.

To reset the database:

```bash
cd /home/grihladin/GriServer_prod/manifest
docker compose down -v
docker compose up -d
```

This destroys all data — do not do this on a production instance.

## Connecting Local LLM Servers

Manifest can use local LLM servers (Ollama, LM Studio, etc.) running on the host.

The compose file includes `extra_hosts: host.docker.internal:host-gateway` which allows the container to reach the host at `http://host.docker.internal:<port>`.

Default Ollama endpoint inside the container:

```text
http://host.docker.internal:11434
```

To use a different LLM server, set `OLLAMA_HOST` in `.env`.