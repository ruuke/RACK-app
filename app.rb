class App

  def call(env)
    @env = env
    [status, headers, body]
  end

  private

  def status
    200
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    ["#{time_now}\n"]
  end  

  def time_now
    path = @env['REQUEST_PATH']
    params, options = (@env['QUERY_STRING']).split('=')    
    time = []
    if path == "/time" && params == "format"
      begin
        options.split('%2C').each do |option|
          time << Time.now.method(option).call
        end
        time.join('-')
      rescue NameError => e
        "Unknown time format #{e}"
      end
      
      else
        options.split('%2')
        formatt
      end
  end

end
