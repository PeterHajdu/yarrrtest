def combined_output
  combined_output = ""
  combined_output << @yarrr_client.output if not @yarrr_client.nil?
  combined_output << @yarrr_server.output if not @yarrr_server.nil?
  return combined_output
end

When(/^I wait a lot$/) do
  sleep 60
end

When(/^I wait a bit$/) do
  sleep 1
end

When(/^I start the client executable with command line parameters (.*)$/) do | parameter |
  @client_home = `mktemp -d`
  @client_home.chomp!
  p "Using temporary home folder: #{ @client_home }"
  @yarrr_client = ProcessRunner.new(
    {
      "SDL_VIDEODRIVER" => "dummy",
      "HOME" => @client_home
    },
    "yarrrclient #{parameter}" )
  @yarrr_client.start
end

When(/^I start a client with command line parameter (.*)$/) do | parameter |
  @server_port||="9871"
  step "I start the client executable with command line parameters --server localhost:#{@server_port} --text #{parameter}"
end

Given(/^a running client$/) do
  step "I start a client with command line parameter "
end

When(/^I start a client$/) do
  step "I start a client with command line parameter "
end

Then(/^the help message should be on the screen$/) do
  steps %Q{
    Then I should see http://yarrrthegame.com
    And I should see info@yarrrthegame.com
    And I should see yarrrclient --server <server:port>
    And I should see --fullscreen
    And I should see --loglevel
    And I should see --username
    And I should see --auth_token
  }
end

When(/^I stop the client$/) do
  @yarrr_client.kill
  sleep 1.0
end

Given(/^a running client without authentication token$/) do
  step "I start a client"
end

Then(/^the client should not be running$/) do
  expect( @yarrr_client.is_running ).to be false
end

When(/^I start (\d+) clients$/) do | number_of_clients |
  @yarrr_clients = []
  next_name = 1
  number_of_clients.to_i.times do
    step "I start a client with command line parameter --username #{ next_name }"
    @yarrr_clients << @yarrr_client
    next_name += 1
  end
end


Then(/^I should see (.+)$/) do | pattern |
  expect( combined_output ).to match( /#{pattern}/ )
end

Then(/^I should not see (.+)$/) do | pattern |
  expect( combined_output ).not_to match( /#{pattern}/ )
end

Then(/^the client should be running$/) do
  expect( @yarrr_client.is_running ).to be true
end

DEFAULT_PORT = 21346

When(/^I start the server with command line parameter (.*)$/) do | parameter |
  @yarrr_server = ProcessRunner.new(
    {},
    "yarrrserver #{parameter}" )
  @yarrr_server.start
end

When(/^I start the server with a port and command line parameter (.*)$/) do | parameter |
  step "I start the server with command line parameter --port 21345 #{ parameter }"
end

When(/^I start the server without any command line parameter$/) do
  step "I start the server with command line parameter "
end

Given(/^a running server$/) do
  @server_port = DEFAULT_PORT
  @remote_model_endpoint = "tcp://127.0.0.1:32199"
  step "I start the server with command line parameter --remote-model-endpoint #{@remote_model_endpoint} -port #{@server_port}"
end

Then(/^the server should be running$/) do
  expect( @yarrr_server.is_running ).to be true
end

Then(/^the server should not be running$/) do
  expect( @yarrr_server.is_running ).to be false
end

Given(/^a connected client with name (.*)$/) do | username |
  step "a running server"
  step "I start a client with command line parameter --username #{ username }"
end

