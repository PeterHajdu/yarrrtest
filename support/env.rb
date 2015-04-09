require 'rspec/expectations'
require_relative './process_runner'

redis_process = ProcessRunner.new( {}, 'redis-server' )
redis_process.start

at_exit do
  redis_process.kill
end

