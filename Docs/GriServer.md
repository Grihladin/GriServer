
Personal VPS for hosting AI services and experiments.

## Specs

- Provider/server IP: `37.114.37.182`
- Host alias: `GriServer`
- OS: Ubuntu 24.04.4 LTS
- CPU: 2 vCPU
- RAM: 7.8 GiB
- Disk: 48 GB root disk
- User: `grihladin`

## Connection

Connect from Mac:

```bash
ssh GriServer
```

## Topics

- [[GriServer - SSH Setup|SSH Setup]]
- [[GriServer - Docker|Docker]]
- [[GriServer - Firewall|Firewall]]
- [[GriServer - Domain|Domain & DNS]]
- [[GriServer - Nginx Proxy Manager|Nginx Proxy Manager]]
- [[GriServer - Landing Page|Landing Page]]
- [[GriServer - Fail2ban|Fail2ban]]
- [[GriServer - Hosting Pattern|Hosting Pattern]]
- [[GriServer - Commands|Useful Commands]]

## Current State

- Docker installed and verified
- Firewall enabled with only SSH, HTTP, and HTTPS allowed inbound
- Fail2ban enabled for SSH protection
- Docker log rotation configured
- Nginx Proxy Manager running for `griserver.com`
- HTTPS enabled with Let's Encrypt for `griserver.com` and `www.griserver.com`

## Purpose

Use this server as a small, production-like playground for Docker-hosted AI services.

For now, services should be deployed with Docker Compose and exposed through a reverse proxy later, not by opening random app ports directly.
