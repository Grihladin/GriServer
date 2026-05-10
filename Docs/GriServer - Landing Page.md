Related: [[GriServer]]

A temporary landing page is running as a separate Docker Compose stack.

## Stack

Stack path:

```text
/opt/stacks/griserver-landing
```

Container:

```text
griserver-landing
```

This container is not exposed directly to the internet. It is only reachable by [[GriServer - Nginx Proxy Manager|Nginx Proxy Manager]] over the internal Docker network:

```text
nginx-proxy-manager_default
```

## Compose File

```yaml
services:
  landing:
    image: nginx:alpine
    container_name: griserver-landing
    restart: unless-stopped
    volumes:
      - ./html:/usr/share/nginx/html:ro
    networks:
      - npm

networks:
  npm:
    external: true
    name: nginx-proxy-manager_default
```
