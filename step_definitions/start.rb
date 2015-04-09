When(/^I plain start yarrr with command line parameter (.*)$/) do | parameter |
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
end

When(/^I start yarrr with command line parameter (.*)$/) do | parameter |
  step "I plain start yarrr with command line parameter --text #{parameter}"
end

When(/^I start yarrr with a server and command line parameter (.*)$/) do | parameter |
  step "I plain start yarrr with command line parameter --server not.existing.domain:2001 --text #{parameter}"
end

Given(/^a running client$/) do
  step "I plain start yarrr with command line parameter --server not.existing.domain:2001 --text"
end

When(/^I start a client$/) do
  step "I plain start yarrr with command line parameter --server not.existing.domain:2001 --text"
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

