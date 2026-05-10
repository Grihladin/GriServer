Related: [[GriServer]]

Fail2ban was installed and enabled.

## SSH Jail

whitelisted localhost and add my grihladin@gmail.com to send email (with sendemail)if it bans sometihng

Current jail:

```text
sshd
```

Purpose:

- Watch SSH authentication logs.
- Detect repeated failed login attempts.
- Temporarily ban attacking IP addresses.

## Status

Check status:

```bash
sudo fail2ban-client status
sudo fail2ban-client status sshd
```
