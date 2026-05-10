Related: [[GriServer]]

## Server Health

```bash
uptime
free -h
df -h /
```

## Docker

```bash
docker ps
docker images
docker compose version
sudo systemctl status docker
docker info --format 'LoggingDriver={{.LoggingDriver}} DockerRootDir={{.DockerRootDir}}'
```

## Nginx Proxy Manager

```bash
cd /opt/stacks/nginx-proxy-manager
docker compose ps
docker compose logs --tail=100
```

## Landing Page

```bash
cd /opt/stacks/griserver-landing
docker compose ps
docker compose logs --tail=100
```

## HTTPS

```bash
curl -I http://griserver.com
curl -I https://griserver.com
curl -I https://www.griserver.com
echo | openssl s_client -connect griserver.com:443 -servername griserver.com 2>/dev/null | openssl x509 -noout -subject -issuer -dates
```

## Firewall

```bash
sudo ufw status verbose
```

## Listening Ports

```bash
ss -tulpn
```

## Fail2ban

```bash
sudo fail2ban-client status sshd
```

## Cleanup

```bash
sudo apt autoremove
```
