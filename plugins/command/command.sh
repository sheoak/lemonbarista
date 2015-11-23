#! /bin/sh

# TODO: helper?
optspec=":-:"
while getopts "$optspec" optchar; do
    case "${optchar}" in
        -)
            case "${OPTARG}" in
                name=*)
                    name=${OPTARG#*=}
                    ;;
                command=*)
                    cmd=${OPTARG#*=}
                    ;;
            esac;;
    esac
done

if [ -z "$cmd" ]; then
    echo "No command specified"
    exit 1
fi

if [ -z "$name" ]; then
    echo "No name specified"
    exit 1
fi

res=`eval $cmd`

cat <<EOF
$name:
    text: $res
EOF
