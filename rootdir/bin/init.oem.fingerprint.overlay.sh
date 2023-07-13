#!/vendor/bin/sh
#
# Identify fingerprint sensor model
#
# Copyright (c) 2019 Lenovo
# All rights reserved.
#
# Changed Log:
# ---------------------------------
# April 15, 2019  chengql2@lenovo.com  Initial version
# April 28, 2019  chengql2  Add fps_id creating step
# December 2, 2019  chengql2  Store fps_id into persist fs, and identify sensor
#                             again when secure unit boots as factory mode.

script_name=${0##*/}
script_name=${script_name%.*}
function log {
    echo "$script_name: $*" > /dev/kmsg
}

persist_fps_id=/mnt/vendor/persist/fps/vendor_id

FPS_VENDOR_FPC=fpc
FPS_VENDOR_NONE=none

PROP_FPS_IDENT=vendor.hw.fps.ident
PROP_GKI_PATH=ro.vendor.mot.gki.path
GKI_PATH=$(getprop $PROP_GKI_PATH)
MAX_TIMES=20

function ident_fps {
    log "- install fpc driver"
    insmod /vendor/lib/modules/$GKI_PATH/fpc1020_mmi.ko
    echo $FPS_VENDOR_FPC > $persist_fps_id
    return 0
}

if [ ! -f $persist_fps_id ]; then
    ident_fps
    exit $?
fi

fps_vendor=$(cat $persist_fps_id)
if [ -z $fps_vendor ]; then
    fps_vendor=$FPS_VENDOR_NONE
fi
log "FPS vendor: $fps_vendor"

if [ $fps_vendor == $FPS_VENDOR_FPC ]; then
    log "- install fpc driver"
    insmod /vendor/lib/modules/$GKI_PATH/fpc1020_mmi.ko
    exit $?
fi

ident_fps
exit $?
