#!/bin/sh

FILE=/tmp/flash_prepare

prepare() {
    adb devices -l | grep transport | awk '{print $3,$5}' > $FILE
}

flash() {
    if [[ ! -f "$FILE" ]]; then
        echo "please prepare first."
        exit 1
    fi
    OLD_IFS=$IFS
    IFS=\n
    devices=`cat /tmp/flash_prepare`
    for device in $devices; do
        IFS=" "
        echo $device | while read usbpath model; do
            echo ${usbpath#usb:}
            echo ${model#model:}
        done
    done
    IFS=OLD_IFS
}

case $1 in 
    prepare) prepare $@;;
    flash) flash $@;;
    *)
        echo "Unknown command: $1"
        exit 1
        ;;
esac
