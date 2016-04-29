#!/bin/bash

echo=$(which echo)
mongodump=$(which mongodump)
dir=/adv/backup/mongo
log=/var/log/mongodump.log

$echo "$(date +%F\ %H:%M:%S) mongodump begin" >> $log
$mongodump -u root -p password --archive=$dir/$(date +%F)-mongodump.gz --gzip >> $log 2>&1
$echo "$(date +%F\ %H:%M:%S) mongodump end" >> $log
