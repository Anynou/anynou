import pandas as pd
import plotly.express as px

import os

def create_index():
    url = 'http://api.open-notify.org/iss-now.json'
    df = pd.read_json(url)

    position = df["iss_position"]

    df['latitud'] = position[0]
    df['longitud'] = position[1]

    fig = px.scatter_geo(df, lat='latitud', lon='longitud')
    fig.write_html('index.html', auto_open=False)

    os.replace("index.html", "templates/index.html")

create_index()
