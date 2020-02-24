FROM python:3.7-slim

# Poetry does not support python 3.7.

ARG AYD_VERSION=13e134238bb8470f89f38dbefa7bb2fa2c754c3a
ARG AYD_URL=https://github.com/PizzaWaffles/Automatic-Youtube-Downloader.git

RUN set -xe \
    && apt-get update \
    && apt-get install -y git ffmpeg \
    && pip3 install "poetry==0.12.11" \
    && mkdir /app \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN set -xe \
    && git clone ${AYD_URL} . \
    && git checkout ${AYD_VERSION} \
    && pip3 install -r requirements.txt \
    && mkdir -p /app/poetry/bin \
    && ln -s /usr/local/bin/poetry /app/poetry/bin/poetry \
    && POETRY_VIRTUALENVS_CREATE=false ./poetry/bin/poetry install --no-interaction --no-ansi

VOLUME [ "/app/data" ]

ENTRYPOINT [ "python3" ]
CMD [ "main.py" ]