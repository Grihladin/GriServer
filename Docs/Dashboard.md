# Dashboard

The dashboard is served at:

```text
https://dashboard.griserver.com
```

It is routed through Cloudflare Tunnel to Nginx Proxy Manager, then proxied to Beszel.

## Stack

Compose directory:

```text
/home/grihladin/GriServer_prod/dashboard_beszel
```

Containers:

```text
dashboard_beszel        Beszel hub
dashboard_beszel_agent  Beszel agent for the local machine and Docker containers
```

The hub listens on port `8090` inside Docker and is also bound locally on the host:

```text
127.0.0.1:8090:8090
```

Nginx Proxy Manager forwards:

```text
dashboard.griserver.com -> dashboard_beszel:8090
```

## Agent

The local Beszel agent uses a Unix socket:

```text
/beszel_socket/beszel.sock
```

Inside the compose project this maps to:

```text
/home/grihladin/GriServer_prod/dashboard_beszel/beszel_socket/beszel.sock
```

When adding the local system in the Beszel UI, use:

```text
/beszel_socket/beszel.sock
```

The agent has read-only Docker socket access:

```text
/var/run/docker.sock:/var/run/docker.sock:ro
```

That is what allows Beszel to show local containers.

## Secrets

Agent credentials live in:

```text
/home/grihladin/GriServer_prod/dashboard_beszel/.env
```

The compose file reads:

```text
BESZEL_AGENT_TOKEN
BESZEL_AGENT_KEY
```

If the agent token/key is regenerated in Beszel, update `.env` and recreate the agent.

## Commands

Start or apply changes:

```bash
cd /home/grihladin/GriServer_prod/dashboard_beszel
docker compose up -d
```

Restart Beszel:

```bash
cd /home/grihladin/GriServer_prod/dashboard_beszel
docker compose restart
```

Repull and recreate:

```bash
cd /home/grihladin/GriServer_prod/dashboard_beszel
docker compose pull
docker compose up -d --force-recreate
```

Check logs:

```bash
docker logs --tail 100 dashboard_beszel
docker logs --tail 100 dashboard_beszel_agent
```

Verify routing:

```bash
curl -I https://dashboard.griserver.com
docker exec nginx-proxy-manager curl -I http://dashboard_beszel:8090
```

## Cloudflare Note

Cloudflare JavaScript challenge or bot features can inject `/cdn-cgi/...` scripts into the Beszel HTML and cause frontend parse errors. If the UI starts showing JSON parse errors, disable Cloudflare JS challenge / Bot Fight style features for `dashboard.griserver.com`.
