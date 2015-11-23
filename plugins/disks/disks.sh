#! /bin/sh

percent=0
optspec=":-:"
while getopts "$optspec" optchar; do
    case "${optchar}" in
        -)
            case "${OPTARG}" in
                percent=*)
                    percent=${OPTARG#*=}
                    ;;
            esac;;
    esac
done

if [ $percent -ne 0 ]; then
    free=`df -h / | awk 'NR==2{print$5}' | sed s/%//g`
    freehome=`df -h ~ | awk 'NR==2{print$5}' | sed s/%//g`
    free=`echo "100 - $free" | bc`%
    freehome=`echo "100 - $freehome" | bc`%
else
    free=`df -h / | awk 'NR==2{print$4}'`
    freehome=`df -h ~ | awk 'NR==2{print$4}'`
fi

cat <<EOF
disk:
    icon: system
    text: $free

disk-home:
    icon: home
    text: $freehome

EOF


