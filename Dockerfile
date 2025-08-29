FROM python:3.14-rc-alpine3.21

WORKDIR /app

COPY requirements.txt .

RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .

ENV FLASH_RUN_HOST=0.0.0.0

EXPOSE 5000

CMD ["flask", "run"]