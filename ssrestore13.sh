#!/bin/sh

# Rodrigo Della Justina 11/10/2017
# Objetivo é restaurar bases que se encontram em um diretório samba
# restauração usando 4 JOBS.

cd '/mnt/disco4tb/restaura13/'


while [ 1 ]; do

export PGPASSWORD=

cd '/mnt/disco4tb/restaura13/'
rename -f 'y/A-Z/a-z/' *
arquivosbackup='*.backup'
for arquivo in $arquivosbackup
do
   echo 'Restaurando base ['$arquivo'] aguarde ;)'
   echo 'Eliminando Conexões existente '
   /usr/lib/postgresql/13/bin/psql -h localhost -U postgres -d postgres -p 8745 -n -c "select pg_terminate_backend(pid) From pg_stat_activity where datname = '"${arquivo%.*}"'"
   wait $!
   echo 'Eliminando (se existir) a base ['"${arquivo%.*}] aguarde ;)"
   /usr/lib/postgresql/13/bin/psql -h localhost -U postgres -d postgres -p 8745 -n -c "DROP DATABASE IF EXISTS "${arquivo%.*}
   wait $!
   echo 'Criando  a base ['"${arquivo%.*}] aguarde ;)"
   /usr/lib/postgresql/13/bin/psql -h localhost -U postgres -d postgres -p 8745 -n -c "CREATE DATABASE "${arquivo%.*}" WITH OWNER = postgres  TEMPLATE template0 ENCODING = 'LATIN1' TABLESPACE = pg_default LC_COLLATE = 'C'  LC_CTYPE = 'C'  CONNECTION LIMIT = -1;"
   wait $!
   echo 'JOB 1 Restaurando a base ['"${arquivo%.*}] aguarde ;)"
   echo 'JOB 2 Restaurando a base ['"${arquivo%.*}] aguarde ;)"
   echo 'JOB 3 Restaurando a base ['"${arquivo%.*}] aguarde ;)"
   echo 'JOB 4 Restaurando a base ['"${arquivo%.*}] aguarde ;)"
   /usr/lib/postgresql/13/bin/pg_restore -h localhost -p 8745 -U postgres -d ${arquivo%.*} --no-password -j 4 --verbose /mnt/disco4tb/restaura13/$arquivo &> /mnt/disco4tb/restaura13/log/${arquivo%.*}.restore.log
   wait $!
   echo 'Eliminando o arquivo de backup  ['$arquivo'] aguarde ;)'
   echo 'Processo finalizado  ['$arquivo'] ;)'
   rm -r '/mnt/disco4tb/restaura13/'$arquivo
done

sleep 5

done

