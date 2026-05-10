Related: [[GriServer]]

## UFW

UFW was installed and enabled.

Current inbound policy:

```text
deny incoming
allow outgoing
deny routed
```

Allowed inbound ports:

```text
22/tcp   SSH
80/tcp   HTTP
443/tcp  HTTPS
```

Everything else inbound is blocked.

## Listening Services

Current public-facing services actually listening:

```text
22/tcp  SSH
80/tcp  Nginx Proxy Manager HTTP
443/tcp Nginx Proxy Manager HTTPS
```

Ports `80` and `443` are handled by [[GriServer - Nginx Proxy Manager|Nginx Proxy Manager]].
