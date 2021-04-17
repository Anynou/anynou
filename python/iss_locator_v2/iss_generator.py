import pandas as pd
import time
import sqlite3
import threading


def generarcoordenadas():

    con = sqlite3.connect('location.db')

    while True:

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
            cursorObj.execute("UPDATE coordenadas SET latitude = ? WHERE id = ?", (latitudes[j], i))
            cursorObj.execute("UPDATE coordenadas SET longitude = ? WHERE id = ?", (longitudes[j], i))
            con.commit()

p = threading.Thread(target=generarcoordenadas)
p.setDaemon(True)
p.start()
p.join()

