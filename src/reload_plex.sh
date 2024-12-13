#!/bin/bash -e

bus=$(lsusb | grep PXQ3PE5 | head -n 1 | grep -oP 'Bus \K\d+' | sed 's/^0*//')

echo "チューナーを usb${bus}-1 にて検知しました"

tail -Fn0 /var/log/kern.log | while read line; do
    echo "$line" | grep "usbcore: deregistering interface driver px4_usb" >/dev/null
    if [ $? = 0 ]; then
        logger -t reload_plex "Detected usbcore: deregistering interface driver px4_usb"
        echo "録画パソコンでエラーが発生しました．録画するには復旧処置が必要です．" | mail -s "[ERROR] 録画パソコン" record
        echo -n "${bus}-1" > /sys/bus/usb/drivers/usb/unbind
        sleep 1
        echo -n "${bus}-1" > /sys/bus/usb/drivers/usb/bind
        sleep 1
        echo "自動復旧処理が完了しました．" | mail -s "[INFO] 録画パソコン" record
    fi
done
