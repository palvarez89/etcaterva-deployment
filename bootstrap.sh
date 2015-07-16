#!/bin/bash

ANSIBLE_DIR=$1
ANSIBLE_PLAYBOOK=$2
ANSIBLE_HOSTS=$3
TEMP_HOSTS="/tmp/ansible_hosts"

if [ ! -f /vagrant/$ANSIBLE_PLAYBOOK ]; then
        echo "Cannot find Ansible playbook"
        exit 1
fi

if [ ! -f /vagrant/$ANSIBLE_HOSTS ]; then
        echo "Cannot find Ansible hosts"
        exit 2
fi

if [ ! -d $ANSIBLE_DIR ]; then
        echo "Updating apt cache"
        apt-get update
        echo "Installing Ansible dependencies and Git"
        apt-get install -y git python-pip
        echo "Cloning Ansible"
        pip install ansible
fi

cp /vagrant/${ANSIBLE_HOSTS} ${TEMP_HOSTS} && chmod -x ${TEMP_HOSTS}
echo "Running Ansible"
bash -c "ansible-playbook /vagrant/${ANSIBLE_PLAYBOOK} --inventory-file=${TEMP_HOSTS} --connection=local -vvvv"
rm ${TEMP_HOSTS}