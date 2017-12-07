#!/bin/bash

date=$(which date)
cdate=$($date +%F)
now=$($date +%F\ %H:%M:%S)
dir=/adv/backup/mysql_dump/
log=/var/log/mysqldump.log
echo=$(which echo)
mkdir=$(which mkdir)
mysql=$(which mysql)
mysqldump=$(which mysqldump)
gzip=$(which gzip)
rm=$(which rm)

$echo "$now cleaning directory from previous backup" >> $log 2>&1
$rm -rf $dir/*
$echo "$now mysqldump begin" >> $log 2>&1
for db in $($mysql -ABNe "show databases;")
    do
        dbdir=$dir/$cdate/$db
        $echo "$now dumping db $db" >> $log 2>&1
        $mkdir -p $dir >> $log 2>&1
        for t in $($mysql -D $db -ABNe "show tables;")
            do
                $mkdir -p $dbdir
                $echo "$now dumping table $t" >> $log 2>&1
                $mysqldump --single-transaction $db $t | $gzip > $dbdir/$t.gz
                $echo "$now done $t" >> $log 2>&1
        done >> $log 2>&1
        $echo "$now done db $db" >> $log 2>&1
    done
$echo "$now mysqldump complete" >> $log 2>&1
