FROM alpine

RUN apk add --update git py3-fonttools npm \
    && git clone https://github.com/kiliman/operator-mono-lig.git \
    && cd operator-mono-lig \
    && apk del git

WORKDIR /operator-mono-lig

ENV HOME="/root" INPUT=$HOME/operator-mono-lig/original OUTPUT=$HOME/operator-mono-lig/build

RUN npm install --production \
    && mkdir build \
    && sed -i 's/bash/sh/g' build.sh \
    && rm -rf /var/cache/apk/*

ENTRYPOINT ["./build.sh"]
