# to delete message in a topic

#!/bin/bash
echo "Enter name of topic to empty:"
read topicName
/$Kafka_Home/bin/kafka-configs --zookeeper localhost:2181 --alter --entity-type topics --entity-name $topicName --add config retention.ms=1000
sleep 5
/$Kafka_Home/bin/kafka-configs --zookeeper localhost:2181 --alter --entity-type topics --entity-name $topicName --delete-config retention.ms
