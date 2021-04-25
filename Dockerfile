FROM node:14-alpine

RUN apk add --no-cache ffmpeg git

RUN mkdir -p /opt/rcj-cms
COPY ./package.json /opt/rcj-cms/package.json
COPY ./bower.json /opt/rcj-cms/bower.json
COPY ./.bowerrc /opt/rcj-cms/.bowerrc
WORKDIR /opt/rcj-cms

RUN npm install && \
    npm install bower -g && \
    npm install workbox-cli -g && \
    bower install --allow-root && \
    mkdir logs && \
    mkdir /data/db -p && \
    mkdir -p /opt/rcj-cms/tmp/course && \
    mkdir -p /opt/rcj-cms/tmp/uploads

WORKDIR /
COPY ./docker/start.sh /start.sh
RUN chmod +x start.sh && \
    dnf remove -y wget git
