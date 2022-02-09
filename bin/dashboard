#!/bin/bash

## Files and cmd
FILE="$HOME/.cache/ewwdashboard.xyz"
EWW="$HOME/.local/bin/eww"
DASHBOARD="$HOME/.config/eww/dashboard"

## Run eww daemon if not running already
if [[ ! `pidof eww` ]]; then
	${EWW} daemon
	sleep 1
fi

## Open widgets 
run_eww() {
	${EWW} -c ${DASHBOARD} open dashboard
}

## Launch or close widgets accordingly
if [[ ! -f "$FILE" ]]; then
	touch "$FILE"
	sh ${DASHBOARD}/scripts/quotes update
	sh ${DASHBOARD}/scripts/getweather --getdata
	run_eww
else
	${EWW} -c ${DASHBOARD} close-all 
	rm "$FILE"
fi
