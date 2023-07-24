#!/bin/sh

[ -x /etc/wifi/variscite-wifi ] || exit 0

case $1 in

"suspend")
        /etc/wifi/variscite-wifi stop
        ifconfig mlan0 down;
        ifconfig wfd0 down;
        ifconfig uap0 down;
        modprobe -r moal;
        ;;
"resume")
        /etc/wifi/variscite-wifi start
        modprobe moal
        if [ -f /etc/init.d/connman ]; then
                killall -9 wpa_supplicant
                /etc/init.d/connman restart
        fi
        if [ -f /etc/systemd/system/multi-user.target.wants/connman.service ]; then
                killall -9 wpa_supplicant
                systemctl restart connman.service
        fi
        ;;
esac

