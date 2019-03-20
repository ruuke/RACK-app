class App

  def call(env)
    perform_response(env)
  end

  private

  def perform_response(env)
    rack = Rack::Request.new(env)

    path  = rack.path
    rack_params = rack.params['format']

    if path != '/time' || rack_params.nil?
      return [404, headers, ['404']]
    end

    formatter = TimeFormatter.new(rack_params)
    if formatter.valid?
      body = formatter.time
      status = 200
    else
      invalid_params = formatter.invalid_params
      body = "Unknown time format #{invalid_params}"
      status = 400
    end
    [status, headers, [body]]

  end

  def headers
    { 'Content-Type' => 'text/plain'}
  end

end
