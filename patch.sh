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

## eleven-ultralegacy-devices
./vendor/lineage/build/tools/repopick.py -P art -f 286185
./vendor/lineage/build/tools/repopick.py -P external/perfetto 287706
./vendor/lineage/build/tools/repopick.py -P system/core 289133
./vendor/lineage/build/tools/repopick.py -P vendor/lineage 289841

# Boringssl-compat
./vendor/lineage/build/tools/repopick.py -P external/sony/boringssl-compat 290309

## bionic
./vendor/lineage/build/tools/repopick.py -P bionic -f 286304 286305

## bootable/recovery
./vendor/lineage/build/tools/repopick.py -P  bootable/recovery -f 286351

## device/lineage/sepolicy
./vendor/lineage/build/tools/repopick.py 287771

## frameworks/av
./vendor/lineage/build/tools/repopick.py -t eleven-legacy-camera

## frameworks/opt/telephony
./vendor/lineage/build/tools/repopick.py -P frameworks/opt/telephony 288106 288536 288537

## hardware/qcom-caf/wlan
./vendor/lineage/build/tools/repopick.py 287117-287119 287124-287126 290021

## packages/services/Telecomm
./vendor/lineage/build/tools/repopick.py -P packages/services/Telecomm 288107

## prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9
./vendor/lineage/build/tools/repopick.py -g https://review.aosip.dev -P prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9 -f 14435

## system/vold
./vendor/lineage/build/tools/repopick.py -t eleven-vold

## packages/apps/LineageParts
./vendor/lineage/build/tools/repopick.py 286435 286449

#################################################################
# PATCHES
#
# Example: apply_patch [REPO_DIR] [PATCH_FILE]
#################################################################

apply_patch $TOP/vendor/lineage $PATCH_DIR/0001-TEMP-Disable-ADB-authentication.patch
