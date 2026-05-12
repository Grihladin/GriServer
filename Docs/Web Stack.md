Related: [[GriServer]], [[Docker]]

## Domain

Domain: `griserver.com`

DNS is managed in Cloudflare.

Server IP: `37.114.37.182`

Current DNS:

```text
griserver.com    Tunnel    griserver    Proxied
```

Public web traffic routes through the Cloudflare Tunnel.

## Routing

Public traffic flows through Cloudflare Tunnel into Nginx Proxy Manager:

```text
User -> Cloudflare -> cloudflared -> Nginx Proxy Manager -> Docker services
```

Cloudflare handles public HTTPS and edge routing. Nginx Proxy Manager routes HTTP traffic to internal Docker services.

## Nginx Proxy Manager

Folder: `nginx-proxy-manager/`

Containers:

```text
nginx-proxy-manager
cloudflared
```

Local bindings:

```text
127.0.0.1:80    HTTP
127.0.0.1:81    NPM Admin UI
```

Credentials: Tunnel token is stored in `.env` file, not hardcoded in docker-compose.

## Cloudflare Tunnel

`cloudflared` runs in Docker with a tunnel token from Cloudflare Zero Trust. It initiates outbound connectivity to Cloudflare, so the server does not need public inbound web ports for normal traffic.

## Landing Page

A temporary landing page runs as `griserver-landing` from:

```text
/opt/stacks/griserver-landing
```

It is attached to the `nginx-proxy-manager_default` Docker network and is reached through Nginx Proxy Manager, not directly from the internet.
