#!/bin/bash

. build/envsetup.sh

PATCH_DIR=${PWD}

echo "TOP: $PATCH_DIR"

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
    cd $PATCH_DIR
    echo ""
}

#################################################################
# CHERRYPICKS                                                   #
#                                                               #
# Examples:                                                     #
# repopick [CHANGE_NUMBER]                                      #
#################################################################

# android_build_soong
repopick -f 327111

# Ultra Legacy
repopick -P art -f 318097
repopick -P external/perfetto -f 287706
repopick 321934 326385
repopick -P system/bpf -f 320591
repopick -P system/netd -f 320592

# frameworks/av
repopick 320337

# Camera - twelve-qcom-cam - twelve-hal1-legacy
repopick -t twelve-restore-camera-hal1
repopick -t twelve-camera-extension
repopick 320528-320530                              
repopick -P hardware/interfaces 320531-320532
repopick -t twelve-legacy-camera

# Extras
repopick 320514

#################################################################
# PATCHES
#
# Example: apply_patch [REPO_DIR] [PATCH_FILE]
#################################################################

# Davey logspam
apply_patch $PATCH_DIR/frameworks/base $PATCH_DIR/0001-hwui-Silence-Davey-logs-for-now.patch

# Legacy telephony stuff
apply_patch $PATCH_DIR/frameworks/opt/telephony $PATCH_DIR/0001-telephony-Squashed-support-for-simactivation-feature.patch
apply_patch $PATCH_DIR/frameworks/opt/telephony $PATCH_DIR/0002-Avoid-SubscriptionManager-getUriForSubscriptionId-ca.patch
apply_patch $PATCH_DIR/frameworks/opt/telephony $PATCH_DIR/0003-RIL-Fix-manual-network-selection-with-old-modem.patch
apply_patch $PATCH_DIR/frameworks/opt/telephony $PATCH_DIR/0004-2G-wants-proper-signal-strength-too.patch
apply_patch $PATCH_DIR/frameworks/opt/telephony $PATCH_DIR/0005-Telephony-Add-option-for-using-regular-poll-state-fo.patch

# System sepolicy
apply_patch $PATCH_DIR/system/sepolicy $PATCH_DIR/0001-Fix-storaged-access-to-sys-block-mmcblk0-stat-after-.patch
apply_patch $PATCH_DIR/system/sepolicy $PATCH_DIR/0002-sepolicy-Treat-proc-based-DT-fstab-the-same-and-sys-.patch
apply_patch $PATCH_DIR/system/sepolicy $PATCH_DIR/0003-Allow-init-to-write-to-proc-cpu-alignment.patch
