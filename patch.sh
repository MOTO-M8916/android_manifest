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

# Ultra Legacy
repopick -P art 318097
repopick -f 287706 -P external/perfetto
repopick 318458
repopick -P system/bpf 320591
repopick -P system/netd 320592

# hardware/qcom/wlan
repopick 318781

# packages/apps/Etar
repopick 319630-319634

# packages/apps/Trebuchet
repopick 317966-317971 318383-318385 318388

# frameworks/base
repopick 318459

# Camera
repopick -t twelve-restore-camera-hal1
repopick -t twelve-camera-extension
repopick 320528-320530                              # twelve-qcom-cam
repopick -P hardware/interfaces 320531-320532       # twelve-qcom-cam
repopick -t twelve-legacy-camera

# Extras
repopick 320514

#################################################################
# PATCHES
#
# Example: apply_patch [REPO_DIR] [PATCH_FILE]
#################################################################

# Display 8916
apply_patch $PATCH_DIR/hardware/qcom-caf/msm8916/display $PATCH_DIR/0001-hwc-Update-dependencies-for-S.patch
