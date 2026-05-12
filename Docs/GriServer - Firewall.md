Related: [[GriServer]]

## UFW

UFW is enabled with default deny incoming policy.

## Current Rules

```text
22/tcp        SSH (open to all)
80,443/tcp    Cloudflare IPs only (v4 and v6)
```

## Rationale

Ports 80/443 allow only Cloudflare IPs as a secondary security layer. The primary security is handled by Cloudflare Tunnel, which does not require open inbound ports on the server.

## Cloudflare IPs

IPv4 ranges allowed:
```text
173.245.48.0/20
103.21.244.0/22
103.22.200.0/22
103.31.4.0/22
141.101.64.0/18
108.162.192.0/18
190.93.240.0/20
188.114.96.0/20
197.234.240.0/22
198.41.128.0/17
162.158.0.0/15
104.16.0.0/13
104.24.0.0/14
172.64.0.0/13
131.0.72.0/22
```

IPv6 ranges allowed:
```text
2400:cb00::/32
2606:4700::/32
2803:f800::/32
2405:b500::/32
2405:8100::/32
2a06:98c0::/29
2c0f:f248::/32
```

## Why No Direct Access

- Nginx Proxy Manager binds to 127.0.0.1 only (not 0.0.0.0)
- Docker manages its own iptables
- Cloudflare Tunnel handles all external traffic

## Listening Services

Public-facing services:
```text
22/tcp   SSH
```

No services bound to public ports. All web traffic flows through Cloudflare Tunnel which initiates outbound connections to Cloudflare.