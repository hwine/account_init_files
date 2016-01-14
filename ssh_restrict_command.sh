#!/bin/bash

set -eu

LOG_FILE=/tmp/$USER-cmds
now=$(date --iso=sec --utc)
{
    echo "$now: env: $(env | grep SSH)"
    echo "$now: arg: $@"
}  >> $LOG_FILE

ALLOWED_COMMANDS=(
    "cat /home/vcs2vcs/vcssync1/build/upload/gecko-mapfile"
)

for cmd in "${ALLOWED_COMMANDS[@]}"; do
    if test "$cmd" = "${SSH_ORIGINAL_COMMAND:=/bin/false}"; then
        echo -e "$now: Accepted\n" >>$LOG_FILE
        exec $SSH_ORIGINAL_COMMAND "$@"
    fi
done

echo -e "$now: REFUSED\n" >>$LOG_FILE

# vim: sw=4 ts=4 sts=4 et ai :
