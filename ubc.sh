#!/bin/sh

## This script is for zabbix-agend driven host with OpenVZ containers
## It gets info about OpenVZ containers by parising /proc/user_beancounters
## Exec it on host runing OpenVZ, not inside OpenVZ container.

CTID="$1" # OpenVZ container id.
RES="$2"  # Param to check (e.g. numproc). For complete list see /proc/user_beancounters
TYPE="$3" # Param type (2 - held, 3 - maxheld, 4 - barrier, 5 - limit, 6 - failcnt)

if [ "$RES" = "kmemsize" ]
        then
        cat /proc/user_beancounters | grep -A 23 "$CTID:" | grep -w "$RES" | awk '{print $'`expr $TYPE + 1`'}'
else
        cat /proc/user_beancounters | grep -A 23 "$CTID:" | grep -w "$RES" | awk '{print $'$TYPE'}'
fi
