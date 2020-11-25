require "kafka"
$kafka = Kafka.new(["broker:9092"])

puts "destination topic: "
$topic = gets.strip

def create_topic(topic)
  begin
    $kafka.create_topic(topic)
  rescue Kafka::TopicAlreadyExists
    puts "Topic #{topic} present. Skipping topic creation..."
  end
end

puts "Producer started"

create_topic($topic)

producer = $kafka.producer
producer.produce("hello", topic: $topic)
producer.produce("sasa", topic: $topic)
producer.produce("vipi", topic: $topic)
producer.produce("oragambaki", topic: $topic)
producer.produce("wasib'ota", topic: $topic)
producer.deliver_messages

producer.shutdown
