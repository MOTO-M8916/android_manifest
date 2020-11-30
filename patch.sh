#!/bin/bash

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
./vendor/lineage/build/tools/repopick.py -P device/motorola/msm8916-common -t eleven_m8916

## Bringup Hax (Disable LiveDisplay & mm-pp-daemon)
#./vendor/lineage/build/tools/repopick.py 290887

## eleven-ultralegacy-devices
./vendor/lineage/build/tools/repopick.py -P art -f 286185
./vendor/lineage/build/tools/repopick.py -P external/perfetto 287706
./vendor/lineage/build/tools/repopick.py -P system/core 292788
./vendor/lineage/build/tools/repopick.py -P vendor/lineage 289841

## hardware/qcom-caf/msm8916/audio
./vendor/lineage/build/tools/repopick.py -P hardware/qcom-caf/msm8916/audio 293096-293098

## hardware/qcom-caf/msm8916/display
./vendor/lineage/build/tools/repopick.py -P hardware/qcom-caf/msm8916/display 293099-293100

## hardware/qcom-caf/msm8916/media
./vendor/lineage/build/tools/repopick.py -P hardware/qcom-caf/msm8916/media 293101-293104

## hardware/qcom-caf/wlan
./vendor/lineage/build/tools/repopick.py 287125 287126 290021

## hardware/ril
./vendor/lineage/build/tools/repopick.py -P hardware/ril 286832 287533 287534 287535 287536

## system/sepolicy
./vendor/lineage/build/tools/repopick.py -P system/sepolicy 292244 292766 292767

## system/vold
./vendor/lineage/build/tools/repopick.py -t eleven-vold

## Trebuchet
./vendor/lineage/build/tools/repopick.py -t eleven-trebuchet -e 289536

## SurfaceFlinger
./vendor/lineage/build/tools/repopick.py -t eleven-disable-postrender-cleanup

#################################################################
# PATCHES
#
# Example: apply_patch [REPO_DIR] [PATCH_FILE]
#################################################################
