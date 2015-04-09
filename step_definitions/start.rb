When(/^I start a client with command line parameters (.*)$/) do | parameter |
  @tmp_home = `mktemp -d`
  @tmp_home.chomp!
  p "Using temporary home folder: #{ @tmp_home }"
  @yarrr_client = ProcessRunner.new(
    {
      "SDL_VIDEODRIVER" => "dummy",
      "HOME" => @tmp_home
    },
    "yarrrclient #{parameter}" )
  @yarrr_client.start
  sleep 1.0
  expect( @yarrr_client.is_running ).to be true
end

When(/^I start a client with command line parameter (.*)$/) do | parameter |
  step "I start a client with command line parameters --server localhost:#{@server_port} --text #{parameter}"
end

Given(/^a running client$/) do
  step "I start a client with command line parameter"
end

When(/^I start a client$/) do
  step "I start a client with command line parameter"
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

Then(/^I should see (.+)$/) do | pattern |
  expect( @yarrr_client.output ).to match( /#{pattern}/ )
end

Then(/^I should not see (.+)$/) do | pattern |
  expect(  @yarrr_client.output ).not_to match( /#{pattern}/ )
end

Then(/^the client should be running$/) do
  expect( @yarrr_client.is_running ).to be true
end

