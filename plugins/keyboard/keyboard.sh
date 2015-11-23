#! /bin/sh

layout=` setxkbmap -print | awk -F"+" '/xkb_symbols/ {print $2}'  \
    | sed 's/(/-/g' | sed 's/_.*//g'`

echo "keyboard:"
echo "    icon: keyboard"
echo "    text: $layout"
