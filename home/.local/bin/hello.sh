#!/usr/bin/sh

NAME="Rxyhn"
APPNAME=609

while true ; do


    datey=$(date +%H)

    if [[ "$datey" -lt 11 ]] ; then
        dunstify -i /usr/share/icons/Papirus-Dark/48x48/emotes/emote-love.svg "Good Morning" "$NAME!" -u low -a $APPNAME
    elif [[ "$datey" -lt 16 ]] ; then
        dunstify -i /usr/share/icons/Papirus-Dark/48x48/emotes/emote-love.svg "Good Afternoon" "$NAME!" -u low -a $APPNAME
    elif [[ "$datey" -lt 18 ]] ; then
        dunstify -i /usr/share/icons/Papirus-Dark/48x48/emotes/emote-love.svg "Good Evening" "$NAME!" -u low -a $APPNAME
    elif [[ "$datey" -lt 22 ]] ; then
        dunstify -i /usr/share/icons/Papirus-Dark/48x48/emotes/emote-love.svg "Nighty" "$NAME!" -u low -a $APPNAME
    elif [[ "$datey" -lt 0 ]] ; then
        dunstify -i /usr/share/icons/Papirus-Dark/48x48/emotes/emote-love.svg "Go to sleep" "$NAME!" -u low -a $APPNAME
    elif [[ "$datey" -lt 3 ]] ; then
        dunstify -i /usr/share/icons/Papirus-Dark/48x48/emotes/face-devilish.svg "Demons are watching you..." -u low -a $APPNAME
    fi
    sleep 3600

done