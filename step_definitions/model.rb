
When(/^I gather model information$/) do
  @model_extractor = ModelExtractor.new( @remote_model_endpoint )
  @model = @model_extractor.extract_model
  expect( @model ).to have_key( "players" )
  @model[ "players" ] ||= {}
  p @model
end

Then(/^I should be able to get model information$/) do
  step( "I gather model information" )
end

Then(/^a player with name "(.*?)" should be online$/) do | player |
  expect( @model["players"] ).to have_key( player )
end

Then(/^a player with name "(.*?)" should not be online$/) do | player |
  expect( @model["players"] ).not_to have_key( player )
end

