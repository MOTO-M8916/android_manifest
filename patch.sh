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

## Build Bringup
./vendor/lineage/build/tools/repopick.py -t eleven-build-warnings
./vendor/lineage/build/tools/repopick.py -t eleven-build
./vendor/lineage/build/tools/repopick.py -t eleven-build-bringup

## Art
./vendor/lineage/build/tools/repopick.py -P art -f 286185

## bionic
./vendor/lineage/build/tools/repopick.py -P bionic -f 286301-286305

## bootable/recovery
./vendor/lineage/build/tools/repopick.py -P  bootable/recovery -f 286438 286351

## Build/Make
./vendor/lineage/build/tools/repopick.py -f 256500 286189 286650 287090 288021-288028

## device/lineage/sepolicy
./vendor/lineage/build/tools/repopick.py 287771

## external/perfetto
./vendor/lineage/build/tools/repopick.py -P external/perfetto 287706

## frameworks/base
./vendor/lineage/build/tools/repopick.py 285750 287226

## frameworks/av
./vendor/lineage/build/tools/repopick.py 286170 286171
./vendor/lineage/build/tools/repopick.py -t eleven-legacy-camera

## frameworks/native
./vendor/lineage/build/tools/repopick.py -P frameworks/native -f 287618

## hardware/libhardware
./vendor/lineage/build/tools/repopick.py 287794

## hardware/qcom-caf/wlan
./vendor/lineage/build/tools/repopick.py 287117-287120 287123-287126

## packages/apps/Etar
./vendor/lineage/build/tools/repopick.py -f 285805 285806

## packages/apps/ThemePicker
./vendor/lineage/build/tools/repopick.py -t eleven-theme_picker

## system/core
./vendor/lineage/build/tools/repopick.py -f 286236

## system/tools/mkbootimg
./vendor/lineage/build/tools/repopick.py -P system/tools/mkbootimg -f 287107

## system/vold
./vendor/lineage/build/tools/repopick.py -t eleven-vold

## vendor_qcom_opensource_interfaces
./vendor/lineage/build/tools/repopick.py -f 287010

## packages/apps/LineageParts
./vendor/lineage/build/tools/repopick.py 286435 286449 286412

## Lineage SDK
./vendor/lineage/build/tools/repopick.py -t eleven-sdk-bringup

## QCOM Encryption
##./vendor/lineage/build/tools/repopick.py -t eleven-qcom-encryption

## More picks for Lineage SDK bringup
./vendor/lineage/build/tools/repopick.py -t eleven-display-rotation
./vendor/lineage/build/tools/repopick.py 286439 286451 286390 286452 286444
./vendor/lineage/build/tools/repopick.py -t eleven-linked-volumes

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
