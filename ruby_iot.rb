require 'particle'
require 'pry' 

class AppInterface  
  attr_accessor :access_token, :device_name, :run_application, :device 
  
  def initialize(access_token, device_name, run_application = true)
    @access_token = access_token
    @device_name = device_name 
    @run_application = run_application
    @device = nil 
  end

  def setup 
    client = Particle::Client.new(access_token: @access_token)
    @device = client.device(@device_name)
  end

  def prompt 
    puts "Turn LED ON/OFF:"
    toggle_led = gets.chomp.downcase 
  
    @device.function("led", toggle_led)
  
    puts "Would you like to continue -- YES/NO:"
    decision = gets.chomp.downcase 
  
    @run_application = false unless decision == "yes"
  end
end



# ------- APP -------: 
binding.pry

app = AppInterface.new(ENV["PARTICLE_ACCESS_TOKEN"], "my_spark_1")
app.setup 

while app.run_application == true 
  app.prompt
end


