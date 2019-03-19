class App

  def call(env)
    @time = TimeNow.new(env)
    [status, headers, body]
  end

  private

  def status
    @time.set_status
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
   [ "#{@time.set_body}\n" ]
  end

end
