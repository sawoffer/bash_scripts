#!/bin/bash

echo=$(which echo)
mongodump=$(which mongodump)
params="{datetime:{ \$gte:ISODate(\"$(date --date=-1day +%F)T00:00:00.000Z\"), \$lte:ISODate(\"$(date --date=-1day +%F)T23:59:59.000Z\") }}"
paramsfile=/adv/scripts/mongo_dump_params
dir=/adv/backup/mongo_dump
mkdir=$(which mkdir)
$mkdir -p $dir/$(date --date=-1day +%F)
log=$dir/$(date --date=-1day +%F)-mongo_dump.log
rm=$(which rm)

$rm -rf $dir/*
$echo $params > $paramsfile

$echo "$(date +%F\ %H:%M:%S) mongodump begin" >> $log

for col in col_01 col_02 col_03 col_04
    do
        $mongodump -u root -p password -j 1 -o $dir/$(date --date=-1day +%F)-mongo_dump --db vsk -c $col --authenticationDatabase admin --queryFile $paramsfile --gzip >> $log 2>&1
    done
$echo "$(date +%F\ %H:%M:%S) mongodump end" >> $log
