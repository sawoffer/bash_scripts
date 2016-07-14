#!/bin/bash

date=$(which date)
dir=/adv/backup/mysql_dump/$($date +%F)
log=/var/log/mysqldump.log
echo=$(which echo)
mkdir=$(which mkdir)
mysql=$(which mysql)
mysqldump=$(which mysqldump)
gzip=$(which gzip)

$echo "$($date +%F\ %H:%M:%S) mysqldump begin" >> $log 2>&1
for db in $($mysql -ABNe "show databases;")
    do
        dbdir=/adv/backup/mysql_dump/$($date +%F)/$db
        $echo "$($date +%F\ %H:%M:%S) dumping db $db" >> $log 2>&1
        $mkdir -p $dir >> $log 2>&1
        for t in $($mysql -D $db -ABNe "show tables;")
            do
                $mkdir -p $dbdir
                $echo "$($date +%F\ %H:%M:%S) dumping table $t" >> $log 2>&1
                $mysqldump $db $t | $gzip > $dbdir/$t.gz
                $echo "$($date +%F\ %H:%M:%S) done $t" >> $log 2>&1
            done >> $log 2>&1
        $echo "$($date +%F\ %H:%M:%S) done db $db" >> $log 2>&1
    done
$echo "$($date +%F\ %H:%M:%S) mysqldump complete" >> $log 2>&1
