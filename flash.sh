#!/bin/sh

FILE=/tmp/flash_prepare

prepare() {
    adb devices -l | grep transport | awk '{print $1,$3,$5}' > $FILE
}

run() {
    serial=$1
    model=$2
    usbpath=$3
    IMG_FILE=$4

    pwd
    echo "Flashing $model $usbpath ..."
    adb -s $serial reboot bootloader
    sleep 5
    ./bin/heimdall flash --BOOT $IMG_FILE --usbpath ${usbpath#usb:} 
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
        echo $device | while read serial usbpath model; do
            IMG_FILE=
            case ${model#model:} in
                SM_G9500)
                    IMG_FILE="./roms/G9500-boot.img"
                    ;;
                SM_G9550)
                    IMG_FILE="./roms/G9550-boot.img"
                    ;;
                *)
                    echo "model ${model#model:} not supported"
                    ;;
            esac
            if [ -n "$IMG_FILE" ]; then
                run $serial $model $usbpath $IMG_FILE &
                wait
            fi
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
