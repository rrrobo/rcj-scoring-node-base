#! /bin/bash
echo "必要なディレクトリを作成します"
mkdir -p logs
mkdir -p db
mkdir -p TechnicalDocument
echo "最新版のイメージをDocker Hubよりダウンロードします"
sudo docker pull ryorobo/rcj-rescue-scoring-japan:latest
echo "イメージを起動します"
./run.sh