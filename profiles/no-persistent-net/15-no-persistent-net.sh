#!/bin/bash
# Get rid of annoying persistent-net and biosdevname stuff that makes hell
# break loose if you switch ethernet cards between boots (at the cost of
# some minor inconvenience for machines with two ethernet cards).

rm -f /etc/udev/rules.d/*persistent-net*

# Mask the persistent net generator rule.
ln -s /dev/null /etc/udev/rules.d/75-persistent-net-generator.rules

# Note that ifcfg-eth0.old gets in the way.
rm -f /etc/sysconfig/network-scripts/ifcfg-*.old

# Get rid of biosdevname-based net config files that might have slipped in.
rm -f /etc/sysconfig/network-scripts/ifcfg-em*
rm -f /etc/sysconfig/network-scripts/ifcfg-p*

# Remove any HWADDR lines in ifcfg-*
sed -i '/^HWADDR/d' /etc/sysconfig/network-scripts/ifcfg-*

# Fix the cmdline so that it passes kernel commandline arguments 
# that tell the kernel NOT to use the new udev persistent naming 
# scheme. This adds a line with the form VAR+=" option" to the end 
# of the grub file. This syntax concatenates the option onto the 
# existing variable when the file is read by mkconfig in the next step.
sed -i '/*^GRUB_CMDLINE_LINUX+=.*biosdevname.*/d' /etc/default/grub
echo "GRUB_CMDLINE_LINUX+=\" net.ifnames=0 biosdevname=0\"" >> /etc/default/grub

# make sure that grub knows about the above changes by compiling them into the actual config
grub2-mkconfig -o /boot/grub2/grub.cfg

# Mask udev's rule file for the default policy to disable the assignment of fixed names in Fedora 19
ln -sf /dev/null /etc/udev/rules.d/80-net-name-slot.rules
ln -sf /dev/null /etc/udev/rules.d/80-net-setup-link.rules

