#!/bin/sh

# Rodrigo Della Justina 12/03/2023
# Objetivo é remover os restaure das bases das 8 as 18
# Rodrigo Della Jusitna 12/03/2023

cd '/mnt/disco4tb/script/pg-restore-automatic'

export PGPASSWORD=

kill -9 $(pgrep removerestore.sh)
kill -9 $(pgrep removerestore.sh)
kill -9 $(pgrep removerestore.sh)

nohup /mnt/disco4tb/script/pg-restore-automatic/removerestore.sh &
