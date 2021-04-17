from flask import Flask
from flask import render_template
import os, time

os.system("python iss_initdb.py")
time.sleep(10)
os.system("python iss.py")
os.system("nohup python iss_generator.py >/dev/null 2>&1 &")

app = Flask(__name__)

@app.route('/')
def index():
    from iss import create_index

    return render_template("index.html", reponse=create_index())

if __name__ == '__main__':
    app.config['TEMPLATES_AUTO_RELOAD'] = True
    app.run(host='0.0.0.0', port='80')
