#!/bin/sh

# Rodrigo Della Justina 12/03/2023
# Objetivo é eliminar  o pg_restore durante horario de trabalho 8 as 18
# restauração usando 4 JOBS.




while [ 1 ]; do

horario=$(date +%H)
echo $horario

if [[ $number -ge 8 && $number -le 18 ]]; then

    kill -9 $(ps aux | grep -e pg_restore| awk '{ print $2 }')

else
    echo "fora do horário de trabalho (pg_restore kill)"
fi

sleep 30

done

