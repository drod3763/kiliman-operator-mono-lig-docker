FROM python:alpine

RUN pip install fonttools \
    && apk add --update git npm \
    && git clone https://github.com/kiliman/operator-mono-lig.git \
    && apk del git

WORKDIR /operator-mono-lig

ENV HOME="/root" INPUT=$HOME/operator-mono-lig/original OUTPUT=$HOME/operator-mono-lig/build

RUN npm install \
    && mkdir build \
    && sed -i 's/bash/sh/g' build.sh \
    && rm -rf /var/cache/apk/*

ENTRYPOINT ["./build.sh"]