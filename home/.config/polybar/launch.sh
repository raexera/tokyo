#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

(sleep 2; polybar -r zero) &
(sleep 2; polybar -r one) &
(sleep 2; polybar -r two) &
(sleep 2; polybar -r three) &

echo "Polybar launched..."
