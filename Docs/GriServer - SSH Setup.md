Related: [[GriServer]]

## SSH Setup

Local SSH config:

patched vaulnurablity 
### Copy Fail — CVE-2026-31431

A high-severity vulnerability (CVSS 7.8) nicknamed **Copy Fail** allows an unprivileged local user to write four controlled bytes into the page cache of any readable file on a Linux system and use that to gain root.
sudo rmmod algif_aead 2>/dev/null || true


Security state:
written in both sshd_config and sshd_config.d aslo in admin /etc/ssh/sshd_config

```text
permitrootlogin no
pubkeyauthentication yes
passwordauthentication no
kbdinteractiveauthentication no
```

Meaning:

- Login is SSH-key only.
- Password login over SSH is disabled.
- Direct root SSH login is disabled.
- `grihladin` has passwordless sudo.
