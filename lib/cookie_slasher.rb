# encoding: utf-8

# Rack middleware that removes all the cookies from 404 and 301
# responses, making them safe to be cached by varnish.  Yes, it is a
# heavy-handed approach, but given how touchy-feely rails session
# handling is, it seems to be the only way to guarantee that no cookies
# are present on those cacheable responses.

class CookieSlasher
  def initialize(app, logger=nil)
    @app = app
    @logger = logger
  end

  def call(env)
    status, headers, body = @app.call(env)

    case status
    when 404, 301
      # removes ALL cookies from the response
      cookies_header = read_cookies_header(headers)

      if cookies_header
        log(env, cookies_header)
        delete_cookies_header(headers)
      end
    end

    [status, headers, body]
  end

  private

  def read_cookies_header(headers)
    headers['Set-Cookie']
  end

  def delete_cookies_header(headers)
    headers.delete 'Set-Cookie'
  end

  def log(env, cookies_header)
    path = env['PATH_INFO']

    message = "CookieSlasher: slashing #{cookies_header.inspect} at #{path.inspect}"
    if !@logger && defined?(Rails)
      Rails.logger.warn(message)
    else
      logger = @logger || env['rack.errors']
      logger.write('warn ' + message + "\n")
    end
  end
end
