#!/bin/bash

. build/envsetup.sh

TOP=${PWD}
PATCH_DIR=$TOP

echo "TOP: $TOP"

# ----------------------------------
# Colors
# ----------------------------------
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'

function apply_patch {
    echo -e "${GREEN}Applying patch...${NOCOLOR}"
    echo -e "${LIGHTBLUE}Target repo:${NOCOLOR} $1"
    echo -e "${LIGHTBLUE}Patch file:${NOCOLOR} $2"
    echo ""

    cd $1
    git am -3 --ignore-whitespace $2
    cd $TOP
    echo ""
}

#################################################################
# CHERRYPICKS
#
# Example: ./vendor/lineage/build/tools/repopick.py [CHANGE_NUMBER]
#################################################################

## Device Tree: eleven_m8916
repopick -P device/motorola/msm8916-common -t 18_moto8916

## Bringup Hax (Disable LiveDisplay & mm-pp-daemon)
#repopick 296163

## eleven-ultralegacy-devices
repopick -P art -f 286185
repopick -P external/perfetto 287706
repopick -P system/core 292788
repopick -P vendor/lineage 289841

## hardware/qcom-caf/msm8916/audio
repopick -P hardware/qcom-caf/msm8916/audio 293096-293098

## hardware/qcom-caf/msm8916/display
repopick -P hardware/qcom-caf/msm8916/display 293099-293100

## hardware/qcom-caf/msm8916/media
repopick -P hardware/qcom-caf/msm8916/media 293101-293104

## hardware/qcom-caf/wlan
repopick 287125 290021

## system/sepolicy
repopick -P system/sepolicy 292244 292766 292767

## system/vold
repopick -t eleven-vold

## Snap
cd packages/apps/Snap && git pull "https://github.com/LineageOS/android_packages_apps_Snap" refs/changes/11/294911/1 && cd $TOP

#################################################################
# PATCHES
#
# Example: apply_patch [REPO_DIR] [PATCH_FILE]
#################################################################
