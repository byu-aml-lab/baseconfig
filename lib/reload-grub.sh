#!/bin/bash

# make sure that grub knows about the above changes by compiling 
# them into the actual config. 
# Note: this needs to get run after symlinks are made.
grub2-mkconfig -o /boot/grub2/grub.cfg
