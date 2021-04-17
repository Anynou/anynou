import pandas as pd
import plotly.express as px
import os, time
import sqlite3
import threading
import shutil

def create_index():
    url = 'http://api.open-notify.org/iss-now.json'
    df = pd.read_json(url)

    con = sqlite3.connect('location.db')

    df = df.append({'timestamp':'2021-04-16 14:25:57', 'iss_position':1, 'message':'success'}, ignore_index=True)
    df = df.append({'timestamp':'2021-04-16 14:25:57', 'iss_position':1, 'message':'success'}, ignore_index=True)
    df = df.append({'timestamp':'2021-04-16 14:25:57', 'iss_position':1, 'message':'success'}, ignore_index=True)
    df = df.append({'timestamp':'2021-04-16 14:25:57', 'iss_position':1, 'message':'success'}, ignore_index=True)
    df = df.append({'timestamp':'2021-04-16 14:25:57', 'iss_position':1, 'message':'success'}, ignore_index=True)
    df = df.append({'timestamp':'2021-04-16 14:25:57', 'iss_position':1, 'message':'success'}, ignore_index=True)
    df = df.append({'timestamp':'2021-04-16 14:25:57', 'iss_position':1, 'message':'success'}, ignore_index=True)
    df = df.append({'timestamp':'2021-04-16 14:25:57', 'iss_position':1, 'message':'success'}, ignore_index=True)
    df = df.append({'timestamp':'2021-04-16 14:25:57', 'iss_position':1, 'message':'success'}, ignore_index=True)
    df = df.append({'timestamp':'2021-04-16 14:25:57', 'iss_position':1, 'message':'success'}, ignore_index=True)
    df = df.append({'timestamp':'2021-04-16 14:25:57', 'iss_position':1, 'message':'success'}, ignore_index=True)
    df = df.append({'timestamp':'2021-04-16 14:25:57', 'iss_position':1, 'message':'success'}, ignore_index=True)
    df = df.append({'timestamp':'2021-04-16 14:25:57', 'iss_position':1, 'message':'success'}, ignore_index=True)

    cursorObj = con.cursor()

    latitudes = [lat[0] for lat in cursorObj.execute("SELECT latitude from coordenadas")]
    df['latitud'] = latitudes

    longitudes = [lat[0] for lat in cursorObj.execute("SELECT longitude from coordenadas")]
    df['longitud'] = longitudes


    fig = px.scatter_geo(df, lat='latitud', lon='longitud')
    fig.write_html('index.html', auto_open=False)

    shutil.move("index.html", "templates/index.html")


create_index()
