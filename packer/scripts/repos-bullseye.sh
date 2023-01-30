#!/bin/bash -eux

apt-get -q install apt-transport-https -y
rm -rf /etc/apt/sources.list.d/*

# makes apt work
cat << EOF > /etc/apt/apt.conf.d/99translations
Acquire::Languages "none";
EOF

apt-get -q clean
apt-get -q update -y
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
apt-get -q autoremove -y
