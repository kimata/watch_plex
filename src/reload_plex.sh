#!/bin/bash

tail -Fn0 /var/log/kern.log | while read line; do
    echo "$line" | grep "usbcore: deregistering interface driver px4_usb" >/dev/null
    if [ $? = 0 ]; then
        echo -n "1-1" > /sys/bus/usb/drivers/usb/unbind
        echo -n "2-1" > /sys/bus/usb/drivers/usb/unbind
        echo -n "1-1" > /sys/bus/usb/drivers/usb/bind
        echo -n "2-1" > /sys/bus/usb/drivers/usb/bind
    fi
done
