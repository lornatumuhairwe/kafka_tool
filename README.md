## Setup instructions

docker-compose up
docker build -t rkafka:latest ./pubsub
docker run --rm -it --network=tool_network rkafka:latest sh
ruby producer.rb
ruby consumer.rb
