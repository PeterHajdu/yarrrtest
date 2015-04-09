Then(/^relative directory should exist in the home directory (.*)$/) do | relative_path |
  expect( File.directory?( "#{@client_home}/#{relative_path}" ) ).to be true
end

Then(/^permanent client configuration file should exist with name (.*)$/) do | filename |
  expect( File.exist?(  "#{@client_home}/.yarrr/#{ filename }" ) ).to be true
end

