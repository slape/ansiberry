# ansiberry

## Ansible playbooks for bootstrap provisioning a Raspberry Pi
---
### Main Concept

The idea for these scripts is to have a repo of complete bootstrap provisioners for a headless Raspberry Pi Server.
I want to be able to burn a [headless Raspbian image](https://www.raspberrypi.org/downloads/) onto an SD card, plug the pi into a switch and run a provisioning script.

The script should:
- Wait for the pi to come online at `raspberrypi.local` 
- Once the pi is detected, use `ssh-copy-id` to copy over the default ssh key
- Configure Ansible to read the correct inventory file
- Kick-off Ansible Provisioning
- Provisioning will end with changing the hostname to match the service installed and reboot if needed.
    - Provisioning can include system hardening and password changes.
- The only manual interaction should be accepting the key and authenticating with the pi during the `ssh-copy-id` command.
    - If you know how to automate this part, make a pull request?

### Requirements
#### Ansible Requirements
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) must be installed on the workstation from which you run these scripts.
    - No Ansible configuration needs to be done as the script will point Ansible to it's included `inventory` file.
    - I am using [Ansible Roles](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html) for the file structure, each service is a role.
    - To choose a specific role, find the `provisioners/main.yml` file and uncomment the service you want. 
    
`provisioners/main.ym` should resemble:

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
    - `dd` works too.
- Before ejecting the SD card, create a file named `ssh` on the `BOOT` partition.
    - This file only needs the name `ssh` and does not have any other requirements. (nothing inside the file and no permissions change).
    - The `touch` command is an easy way to create it: `touch /path/to/boot/ssh`
- Eject the SD card and insert it into the raspberry pi.
- When the Pi boots up, Raspbian enables ssh and deletes this ssh file. 

Official info on this [HERE](https://www.raspberrypi.org/documentation/remote-access/ssh/).

##### Enabling SSH on the machine running Ansible
On your Ansisble control machine Ansible will try to use your default ssh key, so it must be present.
- To generate an ssh key, run `ssh-keygen`

### Kicking off the script

At this point you should have:
- Added an `ssh` file to the `BOOT` partition of SD card for the PI
- Verified that you have a default ssh key in `~/.ssh/id_rsa.pub`
- Verified that Ansible and nmap are installed on your workstation.
- Edited the `provisioners/main.yml` to include the service you want
- Plugged the SD card into the Pi and the Pi into your network.
    - The Pi also needs to be plugged into power, unless you get one of these [cool PoE adapters.](https://www.amazon.com/poe-hat/dp/B07GR9XQJH)

From the main `ansiberry` directory, run the `bootstrap.sh` script with: `bash bootstrap.sh`

### Options

You can use one of these server roles to setup the following servers:
- Docker
- Cups
- Snort
- ELK Stack
- DVWA
- SpeedMonitor
- Grafana
- InfluxDB

You can also configure a pi to send logs or docker metrics to an ELK server:
- Filebeat
- Metricbeat

And you can do some basic system hardening:
- System-Hardening

### Other
Many of these scripts download and run docker containers to reduce development time and dependency conflicts.

### Troubleshooting

- When running this script on multiple iterations, if you reimage the SD card with Raspbian, you will need to delete the key for `raspberrypi.local` from your `~/.ssh/known_hosts` file or the bootstrap.sh script will get hung up on 'Waiting for SSH'.

- After running the system hardening role, the hostname has been changed and `sudo` will require a password. These will stop Ansible from connecting on a subsequent run.

Enjoy!

