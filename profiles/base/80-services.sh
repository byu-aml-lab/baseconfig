#!/bin/bash

# Disable the initial configuration (at first boot after install).
systemctl disable firstboot-graphical
systemctl disable initial-setup-graphical
systemctl disable initial-setup-text

# Disable firewalld, which is currently bad (maybe reconsider later).
systemctl disable firewalld

# Disable sendmail, which no one uses.
systemctl disable sendmail
