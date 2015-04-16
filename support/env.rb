require 'rspec/expectations'
require_relative './process_runner'

REDIS_PORT = 8301

redis_process = ProcessRunner.new( {}, "redis-server --bind 127.0.0.1 --port #{ REDIS_PORT }" )
redis_process.start

at_exit do
  redis_process.kill
end

