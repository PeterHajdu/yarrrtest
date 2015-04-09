Then(/^relative directory should exist in the home directory (.*)$/) do | relative_path |
  expect( File.directory?( "#{@tmp_home}/#{relative_path}" ) ).to be true
end

