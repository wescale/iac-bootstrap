#!/usr/bin/env bash
set -e

cd terraform/
find . -name ".terraform" -type d -exec rm -rf {} \;
