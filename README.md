# ansiberry

## Ansible Scripts for configuring a Raspberry Pi
---
### Main Concept

The idea for these scripts is to have a repo of complete provisioning scripts for a headless Raspberry Pi Server.
I want to be able to burn a [headless Raspbian image](https://www.raspberrypi.org/downloads/) onto an SD card, plug the pi into a switch (using ethernet) and run a provisioning script.

The script should:
- Wait for the pi to come online at `raspberrypi.local` 
- Once the pi is detected, use `ssh-copy-id` to copy over my ssh key
- Configure Ansible to read the correct inventory file
- Kick-off Ansible Provisioning
- Provisioning will end with changing the hostname to match the service installed and reboot if needed.
- The only manual interaction should be accepting the key and authenticating with the pi during the `ssh-copy-id` command.

### Requirements

- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) must be installed on the workstation from which you run these scripts.
    - No Ansible configuration needs to be done as the script will point Ansible to it's included `inventory` file.
    - I am using [Ansible Roles](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html) for the file structure, each service is a role.
    - To choose a specific role, find the `provisioners/main.yml` file and uncomment the service you want. It should resemble:

```bash
---
- name: Provision Raspberry Pi
  hosts: raspberrypi.local
  remote_user: pi
  become: yes
  roles:
    - Cups
    # - DVWA
    # - Snort
```

Any role/service that is un-commented here will run when you kick off the bootstrap.sh script.

#### SSH Requirements
##### Enabling SSH on the PI
`ssh` is disabled by default on Raspbian. To enable it a file named `ssh` must be added to the `BOOT` partition of the SD card.
Follow these steps:
- Burn [Raspbian Lite](https://www.raspberrypi.org/downloads/) onto an SD card. 
    - [Etcher](https://www.balena.io/etcher/) is an easy to use tool for this.
- Before ejecting the SD card, create a file named `ssh` on the `BOOT` partition.
    - This file only needs the name `ssh` and does not have any other requirements. (nothing inside the file and no permissions change).
- Eject the SD card and insert it into the raspberry pi.
- When the Pi boots up, Raspbian enables ssh and deletes this ssh file. 

Official info on this [HERE](https://www.raspberrypi.org/documentation/remote-access/ssh/).

##### Enabling SSH on the machine running Ansible
On your Ansisble control machine Ansible will try to use your default ssh key, so it must be present.
- To generate an ssh key, run `ssh-keygen`

### Kicking off the script

At this point you should have:
- Added an `ssh` file to the `BOOT` partition of SD card for the PI
- Edited the `provisioners/main.yml` to include the service you want
- Plugged the SD card into the Pi and the Pi into your network (and the pi plugged into power, of course). 

From the main `ansiberry` directory, run the `bootstrap.sh` script with: `bash bootstrap.sh`

### Options

You can use one of these server roles to setup the following servers:
- Docker
- Cups
- Snort
- ELK Stack
- DVWA

TODO: potentially useful server roles to setup in the future
- [UNIFI](https://pimylifeup.com/rasberry-pi-unifi/)
- [JENKINS](https://pimylifeup.com/jenkins-raspberry-pi/)
- [Pi-hole](https://pimylifeup.com/raspberry-pi-pi-hole/)
- [grafana](https://pimylifeup.com/raspberry-pi-grafana/)
- [mySQL](https://pimylifeup.com/raspberry-pi-mysql/)
- [samba](https://pimylifeup.com/raspberry-pi-samba/)
- [Plex](https://pimylifeup.com/raspberry-pi-plex-server/)
- [Kismet](https://pimylifeup.com/raspberry-pi-network-scanner/)
- [fail2ban](https://pimylifeup.com/raspberry-pi-fail2ban/)
- [speedmonitor](https://pimylifeup.com/raspberry-pi-internet-speed-monitor/)
- [Nextcloud](https://pimylifeup.com/raspberry-pi-nextcloud-server/)
- [TOR access point](https://pimylifeup.com/raspberry-pi-tor-access-point/)
- [openvpn](https://pimylifeup.com/raspberry-pi-vpn-access-point/)

You can also configure a pi to send logs or docker metrics to an ELK server:
- Filebeat
- Metricbeat

### Other
Many of these scripts download and run docker containers to reduce development time and dependency conflicts. I'm ok with that.

Enjoy!

