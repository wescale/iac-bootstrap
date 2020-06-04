#!/usr/bin/env bash
set -e

ansible-playbook ansible/roles/nginx/tasks/main.yml
