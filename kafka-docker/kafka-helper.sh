#!/bin/bash

CONTAINER="kafka-docker-kafka-1"
TOPIC=${1:-my-topic}

echo "🔁 Listing existing topics:"
docker exec -it $CONTAINER kafka-topics --list --bootstrap-server localhost:9092

echo "➕ Creating topic: $TOPIC"
docker exec -it $CONTAINER kafka-topics --create \
  --topic "$TOPIC" \
  --bootstrap-server localhost:9092 \
  --partitions 1 \
  --replication-factor 1

echo "🔍 Describing topic: $TOPIC"
docker exec -it $CONTAINER kafka-topics --describe \
  --topic "$TOPIC" \
  --bootstrap-server localhost:9092

echo "✅ All done. Use below to produce/consume:"
echo
echo "🔹 Producer:"
echo "docker exec -it $CONTAINER kafka-console-producer --broker-list localhost:9092 --topic $TOPIC"
echo
echo "🔹 Consumer:"
echo "docker exec -it $CONTAINER kafka-console-consumer --bootstrap-server localhost:9092 --topic $TOPIC --from-beginning"
