#! /bin/bash
fifo="/tmp/window_${USER}"

[ -e "${fifo}" ] && rm "${fifo}"
mkfifo "${fifo}"

# Window title, "WIN"
xprop -spy -root _NET_ACTIVE_WINDOW | sed -un 's/.*\(0x.*\)/\1/p' > ${fifo} &

barista_out()
{
    title=$(xprop -id $1 | awk '/_NET_WM_NAME/{$1=$2="";print}' | cut -d'"' -f2)
    echo "window:"
    echo "    text: $title"
}

while :; do
  sleep 1s;
done &

cat "${fifo}" | while read x ; do barista_out $x ; done

wait
