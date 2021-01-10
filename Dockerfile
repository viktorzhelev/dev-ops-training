# FROM kennethreitz/pipenv@sha256:e5ee93444c52f36791f799e611d01b6950d819c676723a13c160a918c7f2d786
FROM python:3.7.5-slim-buster
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
EXPOSE 5000

CMD ["flask", "run", "--host=0.0.0.0"]