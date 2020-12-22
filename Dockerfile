FROM python:2-alpine3.11

RUN pip install fonttools \
    && apk add --update git npm \
    && git clone https://github.com/kiliman/operator-mono-lig.git \
    && cd operator-mono-lig \
    && git checkout v2.2.8 \
    && apk del git

WORKDIR /operator-mono-lig

ENV HOME="/root" INPUT=$HOME/operator-mono-lig/original OUTPUT=$HOME/operator-mono-lig/build

RUN npm install \
    && mkdir build \
    && sed -i 's/bash/sh/g' build.sh \
    && rm -rf /var/cache/apk/*

ENTRYPOINT ["./build.sh"]