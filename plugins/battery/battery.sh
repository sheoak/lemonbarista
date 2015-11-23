#! /bin/sh
#
# battery.sh

hidefull=1
present=`cat /sys/class/power_supply/BAT0/present`

optspec=":-:"
while getopts "$optspec" optchar; do
    case "${optchar}" in
        -)
            case "${OPTARG}" in
                hidefull=*)
                    hidefull=${OPTARG#*=}
                    ;;
            esac;;
    esac
done

status=`cat /sys/class/power_supply/BAT0/status`
now=`cat /sys/class/power_supply/BAT0/energy_now`
full=`cat /sys/class/power_supply/BAT0/energy_full`
charge=`echo $now/$full*100 | bc -l`

if [ -z $present ] || ([ $hidefull -eq "1" ] && [ 1 -eq $(echo "$charge > 100" | bc) ]); then
    exit
fi

case "${status}" in
    "Discharging")
        icon="battery-discharging"
        ;;
    "Charging")
        icon="battery-charging"
        ;;
    *)
        icon="battery"
        ;;
esac

charge=`printf "%.0f%%\n" $charge`

cat <<EOF
battery:
    icon: $icon
    text: $charge
EOF
