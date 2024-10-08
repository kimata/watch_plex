#!/bin/bash

tail -Fn0 /var/log/kern.log | while read line; do
    echo "$line" | grep "usbcore: deregistering interface driver px4_usb" >/dev/null
    if [ $? = 0 ]; then
        logger -t reload_plex "Detected usbcore: deregistering interface driver px4_usb"
        echo -n "1-1" > /sys/bus/usb/drivers/usb/unbind
        sleep 1
        echo -n "1-1" > /sys/bus/usb/drivers/usb/bind
        sleep 1
    fi
done
