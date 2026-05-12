Related: [[GriServer]]

## SSH

SSH is configured for key-only access:

```text
PermitRootLogin no
PubkeyAuthentication yes
PasswordAuthentication no
KbdInteractiveAuthentication no
```

The main user has passwordless sudo. Direct root login and password-based SSH login are disabled.

## Firewall

UFW is enabled with default-deny incoming traffic:

```text
22/tcp        SSH
80,443/tcp    Cloudflare IPs only
```

The web stack uses Cloudflare Tunnel, so public HTTP/HTTPS ports do not need direct exposure.

## Fail2ban

Fail2ban is enabled for SSH and uses nftables actions.

```text
sshd      aggressive mode, 10 minute bans, 5 retries
recidive  repeat offenders, 1 week bans, 5 retries
```

## CVE-2026-31431

The Copy Fail vulnerability was handled with a temporary local mitigation by disabling the vulnerable `algif_aead` kernel module. This blocks the known exploit path until the kernel is patched.
