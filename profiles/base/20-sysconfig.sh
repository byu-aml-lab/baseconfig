#!/bin/bash

# Enable kernel sysrq:
echo "kernel.sysrq = 1" >/etc/sysctl.d/sysrq.conf

# Turn off SELinux.
setenforce 0
sed -i 's/^\(SELINUX=\).*$/\1disabled/' /etc/selinux/config

# I like to keep more than 2 kernels.
sed -i 's/^\(installonly_limit=\).*$/\15/' /etc/yum.conf
