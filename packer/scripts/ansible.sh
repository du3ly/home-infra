#!/bin/bash -eux
# Install ansible, required for the ansible-local packer provisioner

apt-get -q update
apt-get -q upgrade -y
apt-get -q install cmake python3 python3-dev python-setuptools build-essential libssl-dev libffi-dev lsof facter python3-pip wget -y

pip3 install -qUr /tmp/requirements.txt --no-cache-dir

# Newer jinja2 breaks cloud-init, need to overrite with existing packages
pip3 uninstall -y jinja2 markupsafe
apt-get install -y --reinstall python3-jinja2 python3-markupsafe
