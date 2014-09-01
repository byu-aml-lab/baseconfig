#!/bin/bash

echo
echo "** Beginning the script $0"
echo

while getopts "ksy" options
do
    case $options in
        s) SHORT="true" ;;
        ?) ;;
    esac
done

if [[ ! -z $SHORT ]]; then
    exit 0
fi

##############################################################################
# RPMFusion Repository

# This will read in variables defining the Fedora version.
. /etc/os-release

site="http://linux.dropbox.com/"
if ! rpm -q nautilus-dropbox; then
    # this assumes the first rpm listed is the right one
    filename=$(curl http://linux.dropbox.com/fedora/$VERSION_ID/x86_64/ | cut -d\" -f2 | grep rpm | head -n1)
    # install
    rpm -Uvh "$site/fedora/$VERSION_ID/x86_64/$filename"
fi
