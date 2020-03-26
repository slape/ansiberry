#!/usr/local/env bash

printf "\n%s" "Waiting for Raspberry Pi to come online..."
while ! ping -c 1 raspberrypi.local &> /dev/null
do
    printf "%c" "..."
    sleep 2
done
printf "\n%s\n"  "Raspberry Pi is online."

printf "Waiting for SSH service to start..."
while ! ssh-copy-id pi@raspberrypi.local 2> /dev/null
do 
    printf "%c" "..."
    sleep 2
done

echo -e "\nStarting Ansible Provision."
sleep 1

ansible-playbook -i provisioners/inventory provisioners/main.yml