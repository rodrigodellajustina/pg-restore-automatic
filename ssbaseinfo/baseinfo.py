import psycopg2
import sys
ghost =  '192.168.70.178'

print(sys.argv)

if len(sys.argv) > 1:
    cPorta = sys.argv[1]
else:
    cPorta = '8794'

conninfo = psycopg2.connect(host=ghost,
                        user='postgres',
                        password='pgsql',
                        dbname='postgres',
                        port='8794')

conn = psycopg2.connect(host=ghost,
                         user='postgres',
                         password='pgsql',
                         dbname='postgres',
                         port=cPorta)

with conn:
    cur01 = conn.cursor()
    cSelect = """
                select datname from pg_database 
                where datname not in ('template1', 'template0', 'postgres')
                order by datname
              """

    cur01.execute(cSelect)
    cur01Data = cur01.fetchall()

    for curbase in cur01Data:
        conn2 = psycopg2.connect(host=ghost,
                                 user='postgres',
                                 password='pgsql',
                                 dbname=curbase[0],
                                 port=cPorta)
        with conn2:
            cur02 = conn2.cursor()
            try:
                cSelect = """
                           select * from (
                            select 
                                current_database() as basededados, 
                                coalesce(to_char(max(dtlogin), 'DD/MM/YYYY'), '') as dtultimologin, 
                                coalesce(to_char(max(dtlogin), 'HH24:MM'), '')    as hrultimologin, 
                                coalesce(current_date-max(cast(dtlogin as date)), 0) as diassemacesso,
                                pg_database_size(current_database()) / 1024 / 1024 / 1024 as tamanho_gb,
                                pg_database_size(current_database()) / 1024 / 1024  as tamanho_mb	
                            from 
                                pcusepid
                            
                            ) as x
                            order by x.diassemacesso desc
                              """

                cur02.execute(cSelect)
                cur02Data = cur02.fetchall()

                for x in cur02Data:
                    with conninfo:
                        cur99 = conninfo.cursor()
                        print(x[0])
                        cpg = 'pg-'+cPorta
                        cInsert = """
                                    insert into infobase (pg, base, dtultimoacesso, hrultimoacesso, diassemuso, gbbase, mbbase) values ('{0}', '{1}', '{2}', '{3}', '{4}', '{5}', '{6}')
                                  """.format(cpg, x[0], x[1], x[2], x[3], x[4], x[5])
                        cur99.execute(cInsert)
            except Exception as e:
                print(e)
                x =0


