FROM python:3.7

WORKDIR /tmp

RUN pip install --no-cache --upgrade pip setuptools

RUN pip install --no-cache-dir flask plotly pandas
RUN mkdir -p /tmp/templates

COPY app.py app.py
COPY iss.py iss.py
COPY iss_generator.py iss_generator.py
COPY iss_initdb.py iss_initdb.py

CMD [ "python", "./app.py" ]
