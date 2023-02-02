#!/bin/sh -eux

tee -a /etc/ssh/sshd_config <<EOF

UseDNS no
EOF
