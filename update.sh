#! /bin/bash
echo "最新版のイメージをDocker Hubからダウンロードします..."
sudo docker pull ryorobo/rcj-rescue-scoring-japan
echo "古いコンテナを停止します..."
sudo docker stop rcj-scoring-japan
echo "古いコンテナを削除します..."
sudo docker rm rcj-scoring-japan
echo "新しいイメージで起動します..."
sudo docker run -d --name rcj-scoring-japan -p 3000:80  -v "$(pwd)"/db:/data/db -v "$(pwd)"/logs:/opt/rcj-scoring-system/logs -v "$(pwd)"/TechnicalDocument:/opt/rcj-scoring-system/TechnicalDocument -v "$(pwd)"/process.env:/opt/rcj-scoring-system/process.env --restart=always ryorobo/rcj-rescue-scoring-japan