#! /bin/bash
echo "最新版のイメージをDocker Hubからダウンロードします..."
sudo docker pull ryorobo/rcj-rescue-scoring-japan
echo "古いコンテナを停止します..."
sudo docker stop rcj-scoring-japan
echo "古いコンテナを削除します..."
sudo docker rm rcj-scoring-japan
echo "新しいイメージで起動します..."
./run.sh