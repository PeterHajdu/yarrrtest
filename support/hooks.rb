require 'redis'

Before do
  @db = Redis.new( :port => REDIS_PORT )
  @db.flushdb
end

After do
  @yarrr_server.kill if not @yarrr_server.nil?
  @yarrr_client.kill if not @yarrr_client.nil?

  if not @yarrr_clients.nil? then

    @yarrr_clients.each do | client |
      client.kill
    end

  end

end

