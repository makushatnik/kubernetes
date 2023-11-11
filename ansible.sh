#!/bin/bash
cd ansible
ansible-playbook -i hosts.ini kube-ansible.yml
