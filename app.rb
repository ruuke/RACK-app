class App

  def call(env)
    @env = env
    time_now
    [status, headers, body]
  end

  private

  def status
    @status
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
    @time = []
    @error = []
    if path == "/time" && params == "format"
      options.split('%2C').each do |option|
        begin         
        @time << Time.now.method(option).call
                
        rescue NameError
          @error << option
        end
      end

    else
      @status = 404
      return
    end
    @error.empty? ? @status = 200 : @status = 400
    @error.empty? ? @body = @time.join('-') : @body = "Unknown time format #{@error}"
  end

end
