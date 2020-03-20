#!/usr/local/env bash

export ANSIBLE_INVENTORY=./provisioners/inventory

printf "\n%s" "Waiting for Raspberry Pi to come online..."
while ! ping -c 1 raspberrypi.local &> /dev/null
do
    printf "%c" " ..."
    sleep 1
done
printf "\n%s\n"  "Raspberry Pi is online. Copying over SSH key."

ssh-copy-id pi@raspberrypi.local

ansible-playbook provisioners/main.yml