class TimeNow

  attr_accessor :set_status, :set_body

  def initialize(env)
    @env = env
    @time = []
    @error = []
    @set_status
    @set_body    
  end

  def parse
    path = @env['REQUEST_PATH']
    params, options = (@env['QUERY_STRING']).split('=')
    if path == "/time" && params == "format"
      options.split('%2C').each do |option|
        begin         
        @time << Time.now.method(option).call
                
        rescue NameError
          @error << option
        end
      end
    else      
      return
    end

    @error.empty? ? self.set_status = 200 : @set_status = 400
    @error.empty? ? @set_body = @time.join('-') : @set_body = "Unknown time format #{@error}"
    [self.set_status, self.set_body]
  end
  
end