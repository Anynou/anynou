from flask import Flask
from flask import render_template
from iss import create_index

app = Flask(__name__)


@app.route('/')
def index():

    return render_template("index.html", response=create_index())

if __name__ == '__main__':
    app.config['TEMPLATES_AUTO_RELOAD'] = True
    app.run(host='0.0.0.0', port='80')