#!/bin/bash
# You can call this script like this:
# $./volume up
# $./volume down
# $./volume mute

DIR="$HOME/.config/dunst"

function get_volume {
      amixer -D pulse get Master | grep '%' | head -n 1 | awk -F'[' '{print $2}' | awk -F'%' '{print $1}'
}

function is_mute {
      amixer -D pulse get Master | grep '%' | grep -oE '[^ ]+$' | grep off
}

function send_notification {
  volume=`get_volume`
  bar=$(seq -s "─" 0 $(($volume / 5)) | sed 's/[0-9]//g')
  if [ "$volume" = "0" ]; then
    icon_name="$DIR/icons/volume-muted.svg"
    bar=""
  else
    if [  "$volume" -lt "10" ]; then
      icon_name="$DIR/icons/volume-low.svg"
    else
      if [ "$volume" -lt "30" ]; then
        icon_name="$DIR/icons/volume-low.svg"
      else
        if [ "$volume" -lt "70" ]; then
          icon_name="$DIR/icons/volume-medium.svg"
        else
          icon_name="$DIR/icons/volume-high.svg"
        fi
      fi
    fi
  fi 
  # Send the notification
  # dunstify " Volume " "$bar" -i $icon_name -r 5555 -u normal
  dunstify "Volume $volume% " -i $icon_name -r 5555 -u normal -h int:value:$(($volume)) 
  # notify-send.sh "Volume : $volume" -i "$icon_name" -t 2000 --replace=555
}

case $1 in
  up)
    # Unmute
	  amixer -D pulse set Master on > /dev/null
	  # +5%
	  amixer -D pulse set Master 5%+ > /dev/null
    send_notification
    ;;
  down)
    # Unmute
	  amixer -D pulse set Master on > /dev/null
    # -5%
	  amixer -D pulse set Master 5%- > /dev/null
    send_notification
    ;;
  mute)
    # Toggle mute
	  amixer -D pulse set Master 1+ toggle > /dev/null
    if is_mute ; then
      icon_name="$DIR/icons/volume-muted.svg"
      dunstify "Mute" -i $icon_name -r 5555 -u normal -h int:value:0
    else
      send_notification
    fi
    ;;
esac
