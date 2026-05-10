Related: [[GriServer]]

## Recommended Pattern

For this VPS, prefer:

```text
Docker Compose + reverse proxy + UFW + backups + monitoring
```

Do not expose app ports like `3000`, `7860`, `8000`, or `8080` directly to the internet.

For public HTTPS later:

- Use [[GriServer - Nginx Proxy Manager|Nginx Proxy Manager]] for certificates and proxy hosts.
- Expose only `80` and `443` publicly.
- Keep admin dashboards private or protected.

## Next Steps

- Create a standard folder for compose stacks, for example `/opt/stacks`.
- Log into Nginx Proxy Manager and change the temporary admin password.
- Create proxy hosts for apps as they are deployed.
- Add backups for compose files, `.env` files, and Docker volumes.
- Add lightweight monitoring such as Uptime Kuma or Netdata.
