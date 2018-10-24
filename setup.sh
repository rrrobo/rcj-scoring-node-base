#! /bin/bash
echo "必要なディレクトリを作成します"
mkdir -p logs
mkdir -p db
mkdir -p TechnicalDocument
echo "最新版のイメージをDocker Hubよりダウンロードします"
sudo docker pull ryorobo/rcj-rescue-scoring-japan:latest
echo "イメージを起動します"
sudo docker run -d --name rcj-scoring-japan -p 3000:80  -v "$(pwd)"/db:/data/db -v "$(pwd)"/logs:/opt/rcj-scoring-system/logs -v "$(pwd)"/TechnicalDocument:/opt/rcj-scoring-system/TechnicalDocument -v "$(pwd)"/process.env:/opt/rcj-scoring-system/process.env --restart=always ryorobo/rcj-rescue-scoring-japan:latest