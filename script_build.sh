#!/bin/bash

# This Script needs one change from the users and have some instructions how to use it, so please do read first 10 Lines of the Script.

# Clone this script in your ROM Repo using following commands.
# cd rom_repo
# curl https://raw.githubusercontent.com/LegacyServer/Scripts/master/script_build.sh > script_build.sh

# Some User's Details. Please fill it with your own details.

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

# CCACHE UMMM!!! Cooks my builds fast

if [ "$use_ccache" = "yes" ];
then
echo -e ${blu}"CCACHE is enabled for this build"${txtrst}
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
export CCACHE_DIR=/home/subins/ccache/superior
ccache -M 50G
fi

if [ "$use_ccache" = "clean" ];
then
export CCACHE_EXEC=$(which ccache)
export CCACHE_DIR=/home/subins/ccache/superior
ccache -C
export USE_CCACHE=1
ccache -M 50G
wait
echo -e ${grn}"CCACHE Cleared"${txtrst};
fi

# Its Clean Time
if [ "$make_clean" = "yes" ];
then
rm -rf out/target/product/*
#make Clean
wait
echo -e ${cya}"OUT dir from your repo deleted"${txtrst};
fi

# To add HostName
export KBUILD_BUILD_USER="sweeto"
export KBUILD_BUILD_HOST="yui"
export DEVICE_MAINTAINERS="Sipun Ku Mahanta"
export BUILD_WITH_GAPPS=true

# Build ROM
. build/envsetup.sh
lunch ${lunch_command}_${device}-userdebug
mka pixys -j24
