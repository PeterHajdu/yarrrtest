def split_up_command_line_parameters( command )
  tokens = []
  command.scan( /(?:([a-zA-Z_0-9\.\-\:\/]+)|"((?:\\.|[^\\"])*)")/ ).map do | word, phrase |
    tokens << word unless word.nil?
    tokens << phrase unless phrase.nil?
  end
  return tokens
end

class ProcessRunner
  attr_reader :command
  attr_reader :output
  attr_reader :is_running

  def initialize( env, command )
    @env = env
    @command = split_up_command_line_parameters( command )
    @output = ""
    @is_running = false
  end

  def start()
    Thread.fork do
      run_process_on_child_thread
    end
    sleep_on_parent_thread_for_a_moment
  end

  def kill()
    return if not is_running

    begin
      Process.kill( 9, @pid )
    rescue Exception => e
      puts "EXCEPTION: #{e.inspect}"
      puts "MESSAGE: #{e.message}"
    end
  end

  private
  def sleep_on_parent_thread_for_a_moment()
    sleep 1.0 / 4.0
  end

  def run_process_on_child_thread()
    puts "starting command: ", @command
    IO.popen( @env, @command ) do | f |
      @pid = f.pid
      puts "command pid is: #{@pid}"
      @is_running = true
      while ( line = f.gets() ) do
        @output << line
      end
      @is_running = false
    end
  end

end

