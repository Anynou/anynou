import pandas as pd
import time
import sqlite3


def sql_connect():
    con = sqlite3.connect('location.db')
    return con

def create_table(con):
    cursorObj = con.cursor()
    cursorObj.execute("DROP TABLE IF EXISTS coordenadas")
    cursorObj.execute("CREATE TABLE coordenadas(id INTEGER, latitude REAL, longitude REAL)")
    con.commit()

def init_db(con):

    latitudes = []
    longitudes = []

    cursorObj = con.cursor()

    for i in range(0,15):

        url = 'http://api.open-notify.org/iss-now.json'
        df = pd.read_json(url)

        position = df["iss_position"]

        time.sleep(3)

        latitudes.append(position[0])
        longitudes.append(position[1])

    for i in range(1,16):
        j = i - 1
        cursorObj.execute("INSERT INTO coordenadas VALUES(?, ?, ?)", (i, latitudes[j], longitudes[j]))
        con.commit()

con = sql_connect()
create_table(con)
init_db(con)
