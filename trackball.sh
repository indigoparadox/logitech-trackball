#!/bin/sh

DEVICE_NAME="Logitech USB Trackball"
MIDDLE_BUTTON=2
LOG="/var/log/trackball.log"
SLEEP=2

if [ x"$1" = x"udev" ]; then
   echo "bouncing..." > $LOG
   /usr/bin/at -M -f "/usr/local/bin/trackball.sh" now
else
   echo "sleeping for $SLEEP..." >> $LOG
   sleep $SLEEP

   export XAUTHORITY=`ls -1 /home/*/.Xauthority | head -n 1`
#   export XAUTHORITY=`/bin/ls -1 /run/user/*/gdm/Xauthority | \
#      /usr/bin/head -n 1`
   export DISPLAY=":`/bin/ls -1 /tmp/.X11-unix/ | /bin/sed -e s/^X//g | \
      /usr/bin/head -n 1`"
   /bin/date >> $LOG
   echo "XAUTHORITY: $XAUTHORITY; DISPLAY: $DISPLAY" >> $LOG
   
   /usr/bin/xinput set-button-map "$DEVICE_NAME" 1 2 3 4 5 6 7 \
      $MIDDLE_BUTTON $MIDDLE_BUTTON >> $LOG 2>&1
   /usr/bin/xinput set-prop "$DEVICE_NAME" "libinput Scroll Method Enabled" \
      0, 0, 1 >> $LOG 2>&1
   /usr/bin/xinput set-prop "$DEVICE_NAME" "libinput Horizontal Scroll Enabled" \
      0 >> $LOG 2>&1
fi

