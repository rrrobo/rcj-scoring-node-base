FROM node:24-alpine

RUN apk add --no-cache \
    ffmpeg \
    git \
    zip \
    unzip \
    wget \
    fontconfig \
    ttf-dejavu

RUN mkdir -p /opt/rcj-cms
WORKDIR /opt/rcj-cms

RUN wget https://raw.githubusercontent.com/robocup-junior/rcj-rescue-cms/refs/heads/develop/2026/package.json -O /opt/rcj-cms/package.json
RUN wget https://raw.githubusercontent.com/robocup-junior/rcj-rescue-cms/refs/heads/develop/2026/package-lock.json -O /opt/rcj-cms/package-lock.json

# Install dependencies, including build-time deps that are removed afterwards
RUN apk add --no-cache --virtual .build-deps \
    python3 \
    make \
    g++ \
    && npm install --production \
    && npm install bower -g \
    && wget https://raw.githubusercontent.com/robocup-junior/rcj-rescue-cms/refs/heads/develop/2026/bower.json -O /opt/rcj-cms/bower.json \
    && wget https://raw.githubusercontent.com/robocup-junior/rcj-rescue-cms/refs/heads/develop/2026/.bowerrc -O /opt/rcj-cms/.bowerrc \
    && bower install --allow-root \
    && npm uninstall bower -g \
    && apk del .build-deps
