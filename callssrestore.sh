#!/bin/sh

# Rodrigo Della Justina 11/10/2017
# Objetivo é restaurar bases que se encontram em um diretório samba
# Rodrigo Della Jusitna 12/11/2022

cd '/mnt/disco4tb/restura94/'

export PGPASSWORD=

kill -9 $(pgrep ssrestore.sh)
kill -9 $(pgrep ssrestore.sh)
kill -9 $(pgrep ssrestore.sh)

nohup /home/public/shell/ssrestore.sh &
