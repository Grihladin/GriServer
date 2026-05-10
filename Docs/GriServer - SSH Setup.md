Related: [[GriServer]]

## SSH Setup

Local SSH config:

```sshconfig
Host GriServer
    HostName 37.114.37.182
    User grihladin
    IdentityFile ~/.ssh/id_ed25519
```

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
