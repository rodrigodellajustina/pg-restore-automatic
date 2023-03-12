import psycopg2
import sys

def vacuum(portp):
    ghost =  '192.168.70.178'

    print(sys.argv)

    if len(sys.argv) > 1:
        cPorta = sys.argv[1]
    else:
        cPorta = portp

    conninfo = psycopg2.connect(host=ghost,
                            user='postgres',
                            password='pgsql',
                            dbname='postgres',
                            port='8794')
    conninfo.autocommit = True

    conn = psycopg2.connect(host=ghost,
                             user='postgres',
                             password='pgsql',
                             dbname='postgres',
                             port=cPorta)
    conn.autocommit = True

    with conn:
        cur01 = conn.cursor()
        cSelect = """
                                     """

        cur01.execute(cSelect)
        cur01Data = cur01.fetchall()


    for curbase in cur01Data:
        conn2 = psycopg2.connect(host=ghost,
                                 user='postgres',
                                 password='pgsql',
                                 dbname=curbase[0],
                                 port=cPorta)
        conn2.autocommit = True
        conn2.set_isolation_level(0)
        with conn2:
            cur02 = conn2.cursor()
            try:
                print("Rodando Vacuum " + curbase[0])
                #cur02.execute("select 1")
                cSelect = """
                                vacuum full analyze
                          """
                print(cSelect)
                cur02.execute("commit")
                cur02.execute(cSelect)
                cur02.execute("commit")
                print("Rodando Vacuum " + curbase[0] + " Finalizado")
            except Exception as e:
                print(e)
                x = 0

if len(sys.argv) > 1:
    cPorta = sys.argv[1]
else:
    cPorta = portp
vacuum(int(cPorta))