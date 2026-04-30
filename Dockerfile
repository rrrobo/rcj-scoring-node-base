FROM node:24
RUN apt install ffmpeg git zip unzip \
    cairo pango libjpeg-turbo giflib librsvg pixman freetype fontconfig ttf-dejavu
RUN apt install build-dependencies wget \
    build-base g++ python3 pkgconfig cairo-dev pango-dev libjpeg-turbo-dev giflib-dev librsvg-dev pixman-dev freetype-dev
RUN mkdir -p /opt/rcj-cms
WORKDIR /opt/rcj-cms
RUN wget https://raw.githubusercontent.com/robocup-junior/rcj-rescue-cms/refs/heads/develop/2026/package.json -O /opt/rcj-cms/package.json
RUN wget https://raw.githubusercontent.com/robocup-junior/rcj-rescue-cms/refs/heads/develop/2026/package-lock.json -O /opt/rcj-cms/package-lock.json
RUN npm install --production
RUN npm install bower -g
RUN wget https://raw.githubusercontent.com/robocup-junior/rcj-rescue-cms/refs/heads/develop/2026/bower.json -O /opt/rcj-cms/bower.json
RUN wget https://raw.githubusercontent.com/robocup-junior/rcj-rescue-cms/refs/heads/develop/2026/.bowerrc -O /opt/rcj-cms/.bowerrc
RUN bower install --allow-root
RUN apk del build-dependencies
RUN npm uninstall bower -g
