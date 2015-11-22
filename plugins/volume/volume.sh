#! /bin/bash

# a dirty sample to test the volume plugin

# Volume, "VOL"
# TODO: only on start
snd_cha=$(amixer get Master | grep "Playback channels:" | awk '{if ($4 == "") {printf "%s: Playback", $3} else {printf "%s %s: Playback", $3, $4}}')
volume=`amixer get Master | grep "${snd_cha}" | awk -F'[]%[]' '/%/ {if ($7 == "off") {print "0"} else {printf "%d", $2}}'`

echo "volume:"
echo "    text: $volume"
echo "    icon: volume"

