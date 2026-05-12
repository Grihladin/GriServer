Related: [[GriServer]], [[GriServer - Nginx Proxy Manager]]

## Overview

Cloudflare Tunnel provides secure access to internal services without opening inbound ports on the server. All traffic flows through Cloudflare's network, with the `cloudflared` container initiating an outbound connection to Cloudflare.

## How It Works

```
User --> Cloudflare Edge --> Tunnel --> cloudflared --> nginx-proxy-manager --> containers
```

1. User requests hit Cloudflare's edge network
2. Cloudflare routes request through the active tunnel
3. `cloudflared` receives the request inside Docker network
4. Nginx Proxy Manager routes to the appropriate container

## Container

```text
Name: cloudflared
Image: cloudflare/cloudflared:latest
Restart: unless-stopped
```

## Configuration

The tunnel is configured with a token in docker-compose.yml:

```yaml
cloudflared:
  image: cloudflare/cloudflared:latest
  container_name: cloudflared
  restart: unless-stopped
  command: tunnel run --token <YOUR_TUNNEL_TOKEN>
  networks:
    - nginx-proxy-manager_default
```

## Getting a Tunnel Token

1. Go to [Cloudflare Zero Trust](https://one.dash.cloudflare.com/)
2. Navigate to Networks → Tunnels
3. Create a new tunnel or use an existing one
4. Copy the token from the tunnel configuration
5. Update the token in docker-compose.yml

## Commands

Check tunnel status:
```bash
docker logs cloudflared
```

Restart tunnel:
```bash
cd /home/grihladin/GriServer_prod/nginx
docker compose restart cloudflared
```

## No Open Ports

The tunnel does not require any inbound ports open on the server. The `cloudflared` container initiates an outbound WebSocket connection to Cloudflare's edge, creating a persistent tunnel through which all traffic flows.

This means:
- No port 80/443 needs to be open on the server
- UFW rules are a secondary layer, not the primary mechanism
- The server is not directly reachable via its public IP for web traffic

## DNS Routing

For the tunnel to receive traffic:
1. Create a DNS record in Cloudflare dashboard
2. Set record type to `CNAME`
3. Point to your tunnel's cloudflared domain (e.g., `tunnel.example.com`)
4. Enable proxy mode (orange cloud)

Alternatively, use Cloudflare Gateway with a public hostname rule to route specific hostname traffic to the tunnel.