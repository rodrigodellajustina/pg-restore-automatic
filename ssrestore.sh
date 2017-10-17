#!/bin/sh

# Rodrigo Della Justina 11/10/2017
# Objetivo é restaurar bases que se encontram em um diretório samba
# restauração usando 4 JOBS.

cd '/home/public/bases/'


while [ 1 ]; do

export PGPASSWORD=

cd '/home/public/bases/'

arquivosbackup='*.backup'
for arquivo in $arquivosbackup
do
   echo 'Restaurando base ['$arquivo'] aguarde ;)'
   echo 'Eliminando Conexões existente '
   psql -h localhost -U postgres -d postgres -p 5432 -n -c "select pg_terminate_backend(pid) From pg_stat_activity where datname = '"${arquivo%.*}"'"
   echo 'Eliminando (se existir) a base ['"${arquivo%.*}] aguarde ;)"
   psql -h localhost -U postgres -d postgres -p 5432 -n -c "DROP DATABASE IF EXISTS "${arquivo%.*}
   echo 'Criando  a base ['"${arquivo%.*}] aguarde ;)"
   psql -h localhost -U postgres -d postgres -p 5432 -n -c "CREATE DATABASE "${arquivo%.*}" WITH OWNER = postgres  TEMPLATE template0 ENCODING = 'LATIN1' TABLESPACE = pg_default LC_COLLATE = 'C'  LC_CTYPE = 'C'  CONNECTION LIMIT = -1;"
   echo 'JOB 1 Restaurando a base ['"${arquivo%.*}] aguarde ;)"
   echo 'JOB 2 Restaurando a base ['"${arquivo%.*}] aguarde ;)"
   echo 'JOB 3 Restaurando a base ['"${arquivo%.*}] aguarde ;)"
   echo 'JOB 4 Restaurando a base ['"${arquivo%.*}] aguarde ;)"
   pg_restore -h localhost -p 5432 -U postgres -d ${arquivo%.*} --no-password -j 4 --verbose "/home/public/bases/"$arquivo &> /home/public/bases/log/${arquivo%.*}.restore.log
   echo 'Eliminando o arquivo de backup  ['$arquivo'] aguarde ;)'
   echo 'Processo finalizado  ['$arquivo'] ;)'
   rm -r '/home/public/bases/'$arquivo
done

sleep 5

done

