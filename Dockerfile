FROM centos:8
MAINTAINER ryorobo <rrrobo@icloud.com>

COPY ./docker/nginx.repo /etc/yum.repos.d/nginx.repo
COPY ./docker/mongodb.repo /etc/yum.repos.d/mongodb.repo
COPY ./docker/nginx.conf /etc/nginx/nginx.conf

RUN set -x && \
    dnf update -y && \
    dnf install -y nginx mongodb-org && \
    dnf install git wget -y && \
    curl -sL https://rpm.nodesource.com/setup_14.x | bash - && \
    dnf install -y nodejs epel-release dnf-plugins-core && \
    dnf config-manager --set-enabled PowerTools && \
    dnf config-manager --set-enabled epel-playground && \
    rpm -ivh https://download1.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm && \
    dnf install -y ffmpeg


RUN mkdir -p /opt/rcj-scoring-system
COPY ./package.json /opt/rcj-scoring-system/package.json
COPY ./bower.json /opt/rcj-scoring-system/bower.json
COPY ./.bowerrc /opt/rcj-scoring-system/.bowerrc
WORKDIR /opt/rcj-scoring-system

RUN npm install && \
    npm install bower -g && \
    npm install workbox-cli -g && \
    bower install --allow-root && \
    mkdir logs && \
    mkdir /data/db -p && \
    mkdir -p /opt/rcj-scoring-system/tmp/course && \
    mkdir -p /opt/rcj-scoring-system/tmp/uploads

WORKDIR /
COPY ./docker/start.sh /start.sh
RUN chmod +x start.sh && \
    dnf remove -y wget git
