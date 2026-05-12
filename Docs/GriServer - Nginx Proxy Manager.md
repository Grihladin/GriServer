Related: [[GriServer]]

Nginx Proxy Manager is running as a Docker Compose stack with Cloudflare Tunnel for secure, portless access.

## Stack

Stack path:
```text
/home/grihladin/GriServer_prod/nginx
```

Containers:
```text
nginx          Nginx Proxy Manager
cloudflared    Cloudflare Tunnel
```

## Architecture

```
User ---> Cloudflare ---> cloudflared tunnel ---> nginx-proxy-manager (127.0.0.1:80/443)
```

Cloudflare handles:
- SSL/TLS termination
- Certificate management
- DDoS protection
- Edge caching

Nginx Proxy Manager handles:
- Reverse proxy to internal services
- HTTP only (no SSL)
- Route requests to containerized apps

## Ports

```text
127.0.0.1:80    HTTP (nginx-proxy-manager)
127.0.0.1:443   HTTPS (nginx-proxy-manager)
127.0.0.1:81    Admin UI
```

Ports are bound to localhost only. No direct internet access to these ports.

## Admin UI

```text
127.0.0.1:81
```

The admin UI is bound to localhost, not exposed publicly.

Open the admin UI from Mac with an SSH tunnel:
```bash
ssh -L 8181:127.0.0.1:81 GriServ
```

Then open:
```text
http://localhost:8181
```

Admin account:
```text
Email: ratkem144@gmail.com
Password: <REDACTED>
```

## Proxy Hosts

When adding proxy hosts:
- **Scheme:** HTTP
- **SSL Certificate:** None
- **Force SSL:** Off

Cloudflare handles HTTPS externally. NPM only sees HTTP traffic from the tunnel.

## Cloudflare Tunnel

The `cloudflared` container maintains a persistent tunnel to Cloudflare.

- No inbound ports needed on the server
- All traffic flows through Cloudflare's network
- Tunnel authenticates with a token stored in docker-compose.yml

## UFW Configuration

UFW allows only Cloudflare IPs on ports 80/443 as a secondary layer. The tunnel itself doesn't require open ports since it initiates outbound connections to Cloudflare.

```text
22/tcp        SSH (open to all)
80,443/tcp    Cloudflare IPs only
```

## Compose File

```yaml
services:
  nginx-proxy-manager:
    image: jc21/nginx-proxy-manager:latest
    container_name: nginx
    restart: unless-stopped
    ports:
      - "127.0.0.1:80:80"
      - "127.0.0.1:443:443"
      - "127.0.0.1:81:81"
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
    networks:
      - nginx-proxy-manager_default

  cloudflared:
    image: cloudflare/cloudflared:latest
    container_name: cloudflared
    restart: unless-stopped
    command: tunnel run --token <TOKEN>
    networks:
      - nginx-proxy-manager_default

networks:
  nginx-proxy-manager_default:
    external: true
```

## SSL

No SSL configured. Cloudflare manages certificates and SSL termination for all traffic.

When adding proxy hosts in the future:
- SSL tab: None
- Scheme: HTTP
- Force SSL: Off

## Removed

- Let's Encrypt certificates removed
- certbot not installed
- No SSL certificates stored on server
- No port 80/443 open to public internet