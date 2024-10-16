#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail
# if shit breaks i at least know where it is
set -x

# Add Terra repositories and installs the repo package
wget "https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo" -O "/etc/yum.repos.d/terra.repo"
rpm-ostree install terra-release