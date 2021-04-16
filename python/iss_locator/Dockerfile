FROM python:3.7

WORKDIR /tmp

# Install python/pip
RUN pip install --no-cache --upgrade pip setuptools

RUN pip install --no-cache-dir flask plotly pandas
RUN mkdir -p /tmp/templates

COPY app.py app.py
COPY iss.py iss.py

RUN python iss.py

CMD [ "python", "./app.py" ]
