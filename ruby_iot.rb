require 'particle'
require 'pry'

$run = true
$device = nil 

def setup 
  client = Particle::Client.new(access_token: "fd40ff6ba93bdaec6e2da441c3071b2af2856e92")
  $device = client.device("my_spark_1")
end

def prompt 
  puts "Turn LED ON/OFF:"
  toggle_led = gets.chomp.downcase 

  $device.function("led", toggle_led)

  puts "Would you like to continue -- YES/NO:"
  decision = gets.chomp.downcase 

  $run = false unless decision == "yes"
end

# ------- APP -------: 

setup

while $run == true 
  prompt
end

