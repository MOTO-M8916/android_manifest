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

## Art
./vendor/lineage/build/tools/repopick.py -P art -f 286185

## bionic
./vendor/lineage/build/tools/repopick.py -P bionic -f 286303-286305

## build/make
./vendor/lineage/build/tools/repopick.py 286207

## bootable/recovery
./vendor/lineage/build/tools/repopick.py -P  bootable/recovery -f 286351

## device/lineage/sepolicy
./vendor/lineage/build/tools/repopick.py 287771

## external/perfetto
./vendor/lineage/build/tools/repopick.py -P external/perfetto 287706

## frameworks/base
./vendor/lineage/build/tools/repopick.py 287226

## frameworks/av
./vendor/lineage/build/tools/repopick.py 286170 286171
./vendor/lineage/build/tools/repopick.py -t eleven-legacy-camera

## frameworks/opt/telephony
./vendor/lineage/build/tools/repopick.py -P frameworks/opt/telephony 288106 288536 288537

## hardware/libhardware
./vendor/lineage/build/tools/repopick.py 287794

## hardware/qcom-caf/wlan
#./vendor/lineage/build/tools/repopick.py 287117-287120 287123-287126

## packages/apps/Etar
./vendor/lineage/build/tools/repopick.py -f 285805 285806

## packages/apps/ThemePicker
./vendor/lineage/build/tools/repopick.py -t eleven-theme_picker

## packages/services/Telecomm
./vendor/lineage/build/tools/repopick.py -P packages/services/Telecomm 288107

## system/core
./vendor/lineage/build/tools/repopick.py -f 286236

## system/vold
./vendor/lineage/build/tools/repopick.py -t eleven-vold

## vendor_codeaurora_telephony
./vendor/lineage/build/tools/repopick.py -f 288320

## packages/apps/LineageParts
./vendor/lineage/build/tools/repopick.py 286435 286449

## QCOM Encryption
##./vendor/lineage/build/tools/repopick.py -t eleven-qcom-encryption

## Linked Volumes
./vendor/lineage/build/tools/repopick.py -t eleven-linked-volumes

## Statusbar
./vendor/lineage/build/tools/repopick.py 287719 287232
./vendor/lineage/build/tools/repopick.py -t eleven-clock-customizations
./vendor/lineage/build/tools/repopick.py -t eleven-network-traffic

## vendor/qcom/opensource/power
./vendor/lineage/build/tools/repopick.py -f 287142-287190

#################################################################
# PATCHES
#
# Example: apply_patch [REPO_DIR] [PATCH_FILE]
#################################################################

apply_patch $TOP/vendor/lineage $PATCH_DIR/0001-TEMP-Disable-ADB-authentication.patch
apply_patch $TOP/system/core $PATCH_DIR/0001-Revert-Move-adbd-s-legacy-USB-implementation-to-fast.patch
apply_patch $TOP/frameworks/base $PATCH_DIR/0001-screenrecord-Lower-encoder-settings-for-legacy-devic.patch
apply_patch $TOP/external/sony/boringssl-compat $PATCH_DIR/0001-boringssl-compat-update-for-R.patch
