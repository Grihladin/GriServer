
Personal VPS for hosting AI services and experiments.

## Server

- IP: `37.114.37.182`
- OS: Ubuntu 24.04.4 LTS
- 2 vCPU (AMD Ryzen™ 9 5950x)
- 8 GB RAM
- 50 GB NVMe storage
- Location: Frankfurt, Germany

## Topics

- [[Docker|Docker]]
- [[Security|Security]]
- [[Web Stack|Web Stack]]

## Current State

- SSH is key-only; root and password login are disabled
- Docker and Docker Compose are installed
- Docker log rotation is configured
- UFW allows SSH, with web traffic restricted to Cloudflare
- Fail2ban protects SSH
- Nginx Proxy Manager and Cloudflare Tunnel route `griserver.com`
- Cloudflare handles public HTTPS; NPM proxies HTTP internally