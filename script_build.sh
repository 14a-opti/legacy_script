#!/bin/bash

# This Script needs one change from the users and have some instructions how to use it, so please do read first 10 Lines of the Script.

# Replace "legacy" with your own SSH Username in lowercase
username=sipun

# Assign values to parameters used in Script from Jenkins Job parameters
use_ccache="$1"
make_clean="$2"
lunch_command="$3"
device="$4"
target_command="$5"

# Colors makes things beautiful
export TERM=xterm

    red=$(tput setaf 1)             #  red
    grn=$(tput setaf 2)             #  green
    blu=$(tput setaf 4)             #  blue
    cya=$(tput setaf 6)             #  cyan
    txtrst=$(tput sgr0)             #  Reset


# Its Clean Time
if [ "$make_clean" = "yes" ];
then
rm -rf out/target/product/*
wait
echo -e ${cya}"OUT dir from your repo deleted"${txtrst};
fi

# To add HostName
export KBUILD_BUILD_USER="sweeto"
export KBUILD_BUILD_HOST="yui"
export SUPERIOR_OFFICIAL=true

# Build ROM
. build/envsetup.sh
lunch superior_whyred-userdebug
mka bacon -j24
