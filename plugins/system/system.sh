#! /bin/sh

# TODO: alert

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
    memory_total=`free | awk 'FNR == 2 {print $2}'`
    memory_usage=`free | awk 'FNR == 2 {print $3}'`
    memory=`echo "$memory_usage * 100 / $memory_total" | bc`%
else
    memory=`free -h | awk 'FNR == 2 {print $4}'`
fi

cat <<EOF
memory:
    icon: memory
    text: $memory

EOF


