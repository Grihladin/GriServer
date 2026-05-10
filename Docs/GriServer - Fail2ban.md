Related: [[GriServer]]

Fail2ban monitors log files and automatically blocks IPs that show malicious behavior, such as repeatedly failing authentication attempts. It works by scanning logs, detecting patterns of brute-force or abuse, and updating the firewall (via nftables) to ban offending IPs temporarily or permanently.

When an IP exceeds the maxretry threshold within the findtime window, fail2ban bans it for the specified bantime. With `bantime.increment = true`, repeat offenders face progressively longer bans.

## SSH Jail

```bash
sudo fail2ban-client status sshd
sudo fail2ban-client status recidive
```

Current stats:
- Currently failed: 1
- Total failed: 27
- Currently banned: 0
- Total banned: 5

## Configuration

`/etc/fail2ban/jail.local`:

```text
[DEFAULT]
banaction = nftables-telegram
banaction_allports = nftables-telegram[type=allports]
backend = systemd
ignoreip = 127.0.0.1/8 ::1
bantime.increment = true

[sshd]
enabled = true
mode = aggressive
bantime = 600
findtime = 600
maxretry = 5

[recidive]
enabled = true
bantime = 604800
findtime = 86400
maxretry = 5
```

## Settings

| Jail | Bantime | Findtime | Maxretry |
|------|---------|----------|----------|
| sshd | 600s (10 min) | 600s (10 min) | 5 |
| recidive | 604800s (1 week) | 86400s (1 day) | 5 |

## Jails

### sshd
Mode: `aggressive` - covers all auth methods (password, publickey, keyboard-interactive, PAM, protocol attacks)

### recidive
Bans repeat offenders for 1 week across all ports. Watches fail2ban's own log for IPs banned multiple times.

## Commands

```bash
sudo fail2ban-client status
sudo fail2ban-client status sshd
sudo fail2ban-client set sshd banip <ip>
sudo fail2ban-client set sshd unbanip <ip>
sudo fail2ban-client get sshd bantime
sudo fail2ban-client get sshd findtime
sudo fail2ban-client get sshd maxretry
```