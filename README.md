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
- The only manual interaction should be accepting the key and authenticating with the pi during the `ssh-copy-id` command.

### Requirements

- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) must be installed on the workstation from which you run these scripts.
    - No Ansible configuration needs to be done as the script will point Ansible to it's included `inventory` file.

- Ansible will use your default ssh key, so it must be present.
    - To generate an ssh key, run `ssh-keygen`

- Because `ssh` is disabled by default on Raspbian, a file named `ssh` must be added to the `BOOT` partition of the SD card _after_ burning the raspbian image. The ssh file can be empty or have text and it can be added from the same computer you use to burn the card. When the pi boots up, Raspbian enables ssh and deletes the ssh file. More info on that [HERE](https://www.raspberrypi.org/documentation/remote-access/ssh/).

### Kicking off the script

Once your pi is plugged into the network, move into directory of the thing you want to provision and run the `kick-off.sh` script.

You can use one of these scripts to setup the following servers:
- Snort
- ELK Stack
- DVWA

You can also configure a pi to send logs or docker metrics to an ELK server:
- Filebeat
- Metricbeat

### Other
Many of these scripts download and run docker containers to reduce development time and dependency conflicts. I'm ok with that.

Enjoy!

