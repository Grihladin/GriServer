Related: [[GriServer]]

Nginx Proxy Manager is running as a Docker Compose stack.

## Stack

Stack path:

```text
/opt/stacks/nginx-proxy-manager
```

Container:

```text
nginx
```

Public ports:

```text
80/tcp   HTTP
443/tcp  HTTPS
```

## Admin UI

```text
127.0.0.1:81
```

The admin UI is intentionally bound to localhost on the server, not exposed publicly.

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

Configured proxy host:

```text
griserver.com
www.griserver.com
```

Forward target:

```text
http://griserver-landing:80
```

## SSL

```text
Provider: Let's Encrypt
Email: ratkem144@gmail.com
Certificate: griserver.com, www.griserver.com
Force SSL: enabled
HTTP/2: enabled
Expires: 2026-08-07 21:19:55 UTC
Issuer: Let's Encrypt E7
```

Auto-renewal:

```text
Enabled by Nginx Proxy Manager
Renewal check: certs expiring within 30 days
Renewal config: /etc/letsencrypt/renewal/npm-1.conf inside the nginx container
Validation method: HTTP-01 through port 80
```

Requirements for renewal:

- The `nginx` container must be running.
- DNS for `griserver.com` and `www.griserver.com` must keep pointing to `37.114.37.182`.
- Port `80` must stay reachable from the public internet.
- Nginx Proxy Manager must keep handling `/.well-known/acme-challenge/` requests.

Verified behavior:

```text
http://griserver.com       -> 301 redirect to https://griserver.com/
https://griserver.com      -> HTTP/2 200
https://www.griserver.com  -> HTTP/2 200
```

## Compose File

```yaml
services:
  nginx-proxy-manager:
    image: jc21/nginx-proxy-manager:latest
    container_name: nginx
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
      - "127.0.0.1:81:81"
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
```
