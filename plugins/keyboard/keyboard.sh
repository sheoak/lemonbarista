#! /bin/sh

layout=` setxkbmap -print | awk -F"+" '/xkb_symbols/ {print $2}'  \
    | sed 's/(/-/g' | sed 's/_.*//g'`

cat <<EOF
keyboard:
    icon: keyboard
    text: $layout
EOF
