#! /bin/sh

optspec=":-:"
showip=0

while getopts "$optspec" optchar; do
    case "${optchar}" in
        -)
            case "${OPTARG}" in
                eth=*)
                    eth=${OPTARG#*=}
                    ;;
                wlan=*)
                    wlan=${OPTARG#*=}
                    ;;
                showip=*)
                    showip=${OPTARG#*=}
                    ;;
            esac;;
    esac
done

# auto-dectect, if not in option
# TODO: on startup
if [ -z $eth ] || [ -z $wlan ]; then
    list=`ls /sys/class/net`

    for interface in $list; do

        case "${interface}" in
            wl*)
                if [ -z $wlan ]; then
                    wlan=$interface
                fi
                ;;
            en*|eth*)
                if [ -z $eth]; then
                    eth=$interface
                fi
                ;;
        esac

    done
fi

if [ ! -z $wlan ] && [ "$wlan" != "0" ]; then
    essid=`iwgetid | grep $interface | cut -d":" -f2 | sed 's/"//g'`

cat <<EOF
wlan:
    icon: wlan
    text: $essid
    group: network
EOF
fi

if [ ! -z $eth] && [ $eth -ne "0" ]; then

cat <<EOF
eth:
    icon: ethernet
    text: on
    group: network
EOF

fi

if [ $showip != "0" ]; then

    ip=`ip route get 1 | awk '{print $NF;exit}'`

    cat <<EOF
ip:
    text: $ip
    group: network
EOF

fi

