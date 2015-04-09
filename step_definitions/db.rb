DEFAULT_USERNAME=ENV[ "LOGNAME" ]

Then(/^the default user should be created in the database$/) do
  expect( @db.exists( "user:#{ DEFAULT_USERNAME }" ) ).to be true
end

Then(/^the default user should have (.*)$/) do | hash_field |
  expect( @db.hexists( "user:#{ DEFAULT_USERNAME }", hash_field  ) ).to be true
end

Given(/^a registered user "(.*?)" with auth_token "(.*?)"$/) do | username, auth_token |
  @db.hset( "user:#{username}", "auth_token", auth_token )
end

Given(/^a registered default user with auth_token (.*)$/) do | auth_token |
  step( "a registered user \"#{DEFAULT_USERNAME}\" with auth_token \"#{auth_token}\"" );
end

Then(/^the default users auth_token should be (.*)$/) do | expected_auth_token |
  auth_token_in_db = @db.hget( "user:#{DEFAULT_USERNAME}", "auth_token" )
  expect( auth_token_in_db ).to eq expected_auth_token
end

Then(/^permanent configuration file "(.*?)" should contain authentication token of user "(.*?)"$/) do | filename , username |
  auth_token_in_db = @db.hget( "user:#{username}", "auth_token" )
  auth_token_in_file = ""
  File.open( full_path_of_permanent_file( filename ) , "r" ) do | tokenfile |
    auth_token_in_file = tokenfile.gets
  end

  expect( auth_token_in_db ).to eq auth_token_in_file
end

