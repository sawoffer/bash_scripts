#!/bin/sh

CTID="$1" # Номер вдски, передаваемый заббиксом.
RES="$2"  # Запрашеваемый ресурс (например numproc)
TYPE="$3" # Тип ресурса (2 - held, 3 - maxheld, 4 - barrier, 5 - limit, 6 - failcn)

if [ "$RES" = "kmemsize" ]
        then
        cat /proc/user_beancounters | grep -A 23 "$CTID:" | grep -w "$RES" | awk '{print $'`expr $TYPE + 1`'}'
else
        cat /proc/user_beancounters | grep -A 23 "$CTID:" | grep -w "$RES" | awk '{print $'$TYPE'}'
fi
