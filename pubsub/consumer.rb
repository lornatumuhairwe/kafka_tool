require "kafka"
$kafka = Kafka.new(["broker:9092"])

puts "source topic: "
$source = gets.strip
puts "destination topic: "
$destination = gets.strip

def create_topic(topic)
  begin
    $kafka.create_topic(topic)
  rescue Kafka::TopicAlreadyExists
    puts "Topic #{topic} present. Skipping topic creation..."
  end
end

puts "Consumer started"

create_topic($source)
puts "Created source topic as #{$source}"
create_topic($destination)
puts "Created destination topic as #{$destination}"

$kafka.each_message(topic: $source) do |message|
  puts "Message read from #{$source}. Offset: #{message.offset}, key: #{message.key}, value: #{message.value}, partition: #{message.partition}"
  $kafka.deliver_message(message.value, topic: $destination)
  puts "Message #{message.value} is posted to #{$destination}"
end
