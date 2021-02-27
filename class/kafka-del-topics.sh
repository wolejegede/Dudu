# Script to delete all kafka topics on a given cluster

#!/bin/bash

TOPICS=$(kafka-topics --zookeeper [ZK_IP]:2181/kafka --list )

for T in $TOPICS
do
  if [ "$T" != "__consumer_offsets" ]; then
    kafka-topics --zookeeper [ZK_IP]:2181/kafka --delete --topic $T
  fi
done
