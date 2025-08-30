FROM python:3.11-alpine

#used the below run from online as i was getting an error in building the dockerfile try using some other base image to make sure there is no issues.
RUN apk add --no-cache gcc musl-dev python3-dev linux-headers

WORKDIR /app

COPY requirements.txt .

RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .

ENV FLASK_RUN_HOST=0.0.0.0

#ENV FLASK_APP=app.py

EXPOSE 8080

CMD ["flask", "run"]
