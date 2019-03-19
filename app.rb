class App

  def call(env)
    @time = TimeNow.new(env).parse
    [status, headers, body]
  end

  private

  def status
    @time.is_a?(NilClass) ? 404 : @time[0]
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
   @time.is_a?(NilClass) ? [ ] : [ "#{@time[1]}\n" ]
  end

end
