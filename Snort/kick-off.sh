#!/usr/local/env bash

export ANSIBLE_INVENTORY=../inventory

printf "%s" "Waiting for Raspberry Pi to come online..."
while ! ping -c 1 -n -w 1 raspberrypi.local &> /dev/null
do
    printf "%c" "."
done
printf "\n%s\n"  "Raspberry Pi is online. Copying over SSH key."

ssh-copy-id pi@raspberrypi.local

ansible-playbook playbook