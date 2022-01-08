name=$(xprop -id $(xdotool getactivewindow) WM_CLASS | awk '{ print $3}')
nam=${name%?}
nam=${nam#?}
nam=${nam%?}

echo ${nam}
