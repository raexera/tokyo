#!/bin/bash
# Opens eww calendar via polybar

LOCK_FILE="$HOME/.cache/eww-calendar.lock"
EWW_BIN="$HOME/.local/bin/eww"

run() {
    ${EWW_BIN} open calendar
}

# Run eww daemon if not running
if [[ ! `pidof eww` ]]; then
    ${EWW_BIN} daemon
    sleep 1
fi

# Open widgets
if [[ ! -f "$LOCK_FILE" ]]; then
    touch "$LOCK_FILE"
    run
else
    ${EWW_BIN} close-all
    rm "$LOCK_FILE"
fi