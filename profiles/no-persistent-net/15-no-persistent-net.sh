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

# Mask udev's rule file for the default policy to disable the assignment of fixed names in Fedora 19
ln -sf /dev/null /etc/udev/rules.d/80-net-name-slot.rules
ln -sf /dev/null /etc/udev/rules.d/80-net-setup-link.rules

# Note: we also pass the arguments "net.ifnames=0 biosdevname=0" to 
# the kernel in /etc/default/grub. In fact, that is what really 
# seems to remove the bios names in practice. The modifications
# in this script keep things tidy, but may not all be necessary.

