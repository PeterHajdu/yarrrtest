def full_path_of_permanent_file( file )
  "#{@client_home}/.yarrr/#{ file }"
end

Then(/^relative directory should exist in the home directory (.*)$/) do | relative_path |
  expect( File.directory?( "#{@client_home}/#{relative_path}" ) ).to be true
end

