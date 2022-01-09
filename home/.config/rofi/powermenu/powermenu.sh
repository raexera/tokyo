dir="$HOME/.config/rofi/powermenu"
rofi_command="rofi -theme $dir/powermenu.rasi"

uptime=$(uptime -p | sed -e 's/up //g')

# Options
shutdown=""
reboot=""
lock=""
suspend=""
logout=""

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -p "$uptime" -dmenu -selected-row 0)"
case $chosen in
$shutdown)
  systemctl poweroff
  ;;
$reboot)
  systemctl reboot
  ;;
$lock)
  if [[ -f /usr/bin/i3lock ]]; then
    bsplock
  elif [[ -f /usr/bin/betterlockscreen ]]; then
    betterlockscreen -l
  fi
  ;;
$suspend)
  ans=$(confirm_exit &)
  if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
    mpc -q pause
    amixer set Master mute
    systemctl suspend
  elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
    exit 0
  else
    msg
  fi
  ;;
$logout)
  if [[ "$DESKTOP_SESSION" == "Openbox" ]]; then
    openbox --exit
  elif [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
    bspc quit
  elif [[ "$DESKTOP_SESSION" == "i3" ]]; then
    i3-msg exit
  fi
  ;;
esac
