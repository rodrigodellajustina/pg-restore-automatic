from flask import Flask, jsonify, render_template
from flask import request
from waitress import serve
import psycopg2

production = True
app = Flask(__name__)
app.config['JSON_SORT_KEYS'] = False
ghost =  '192.168.70.178'
gport = '8794'

@app.route('/baseinfo')
def info():
    conn = psycopg2.connect(host=ghost,
                            user='postgres',
                            password='pgsql',
                            dbname='postgres',
                            port=gport)

    with conn:
        cur01 = conn.cursor()
        cSelect = """                    
                    select 
                        pg as cluster,  
                        base as base,
                        dtultimoacesso ||' '||hrultimoacesso as dtultimoacesso,
                        diassemuso,
                        gbbase,
                        mbbase
                    from 
                        infobase
                    order by diassemuso desc                        
                  """

        cur01.execute(cSelect)
        cur01Data = cur01.fetchall()

    #print("acessou")
    return render_template('index.html', basedata=cur01Data)


if __name__ == "__main__":
    app.run(host=ghost, threaded=True, port="5005")
