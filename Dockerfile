FROM python:3.7-slim

# Poetry does not support python 3.7.

ARG AYD_VERSION=f7ec2f363504cd50628363caa21ed6e0c90363d3
ARG AYD_URL=https://github.com/PizzaWaffles/Automatic-Youtube-Downloader.git

RUN set -xe \
    && apt-get update \
    && apt-get install -y git ffmpeg \
    && mkdir /app \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN set -xe \
    && git clone ${AYD_URL} . \
    && git checkout ${AYD_VERSION} \
    && pip3 install -r requirements.txt \
    && python3 ./poetry/get_poetry.py --version 0.12.11 \
    && ./poetry/bin/poetry install --no-interaction --no-ansi \
    && mkdir ./logs

VOLUME [ "/app/data" ]

ENTRYPOINT [ "python3" ]
CMD [ "main.py" ]