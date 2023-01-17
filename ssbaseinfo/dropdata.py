import psycopg2
import sys

ghost =  '192.168.70.178'
gport =  '8794'

conninfo = psycopg2.connect(host=ghost,
                        user='postgres',
                        password='pgsql',
                        dbname='postgres',
                        port=gport)

with conninfo:
    cur01 = conninfo.cursor()
    cTruncate = """                    
                    truncate table infobase 
                """
    cur01.execute(cTruncate)

