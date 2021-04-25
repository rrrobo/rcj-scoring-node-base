FROM node:14-alpine
RUN apk add --no-cache ffmpeg git zip unzip
RUN mkdir -p /opt/rcj-cms
WORKDIR /opt/rcj-cms
COPY ./package.json /opt/rcj-cms/package.json
RUN npm install
RUN npm install bower -g
RUN npm install workbox-cli -g
COPY ./bower.json /opt/rcj-cms/bower.json
COPY ./.bowerrc /opt/rcj-cms/.bowerrc
RUN bower install --allow-root
RUN mkdir logs && \
    mkdir -p /opt/rcj-cms/tmp/course && \
    mkdir -p /opt/rcj-cms/tmp/uploads
WORKDIR /
COPY ./docker/start.sh /start.sh
RUN chmod +x start.sh
