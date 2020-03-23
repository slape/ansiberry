## System Hardening
This system hardening role provides some basic system hardening for a Raspberry Pi.

Most of the items on [this list](https://www.raspberrypi.org/documentation/configuration/security.md) are implemented, including:

- Change the password
- Change the hostname 
- Schedule automatic updates 
- Force SSH public key usage
- Disable the wlan0 interface
- Installs and Configures UFW (allows only ssh)
- Installs and Configures fail2ban
- Edits `sudoers` to require a password for `sudo`

**NOTE:** After running this role, Ansible will lose a connection and not be able to connect again as the hostname has changed.