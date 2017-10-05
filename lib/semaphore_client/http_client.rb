class SemaphoreClient

  class HttpClient

    class ResponseErrorMiddleware < Faraday::Middleware
      def call(env)
        @app.call(env).on_complete do |env|
          case env[:status]
          when 401
            raise SemaphoreClient::Exceptions::Unauthorized, env
          when 404
            raise SemaphoreClient::Exceptions::NotFound, env
          when 405
            raise SemaphoreClient::Exceptions::NotAllowed, env
          when 409
            raise SemaphoreClient::Exceptions::Conflict, env
          when 422
            raise SemaphoreClient::Exceptions::UnprocessableEntity, env
          when 400...500
            raise SemaphoreClient::Exceptions::BadRequest, env
          when 500...600
            raise SemaphoreClient::Exceptions::ServerError, env
          end
        end
      end
    end

    def initialize(auth_token, api_url, api_version, logger, auto_paginate)
      @auth_token = auth_token
      @api_url = api_url
      @api_version = api_version
      @logger = logger
      @auto_paginate = auto_paginate
    end

    def get(path, params = nil, options = {})
      api_call(:get, path, params, options)
    end

    def post(path, params = nil, options = {})
      api_call(:post, path, params, options)
    end

    def patch(path, params = nil, options = {})
      api_call(:patch, path, params, options)
    end

    def delete(path, params = nil, options = {})
      api_call(:delete, path, params, options)
    end

    private

    def api_call(method, path, params = nil, options = {})
      response = connection.public_send(method, "/#{@api_version}/#{path}", params)

      if auto_paginate?(options)
        links = parse_links(response)

        if links[:next]
          # recursivly follow the :next link
          next_response = api_call(method, links[:next], params, options)

          # append the rest to the body of the original request
          response.body.concat(next_response.body)
        end
      end

      response
    end

    def auto_paginate?(options)
      # first check the options, then the global settings
      options.key?(:auto_paginate) ? options[:auto_paginate] : @auto_paginate
    end

    def parse_links(response)
      links = ( response.headers["Link"] || "" ).split(', ').map do |link|
        href, name = link.match(/<(.*?)>; rel="(\w+)"/).captures

        [name.to_sym, href.gsub("#{@api_url}/v2", "")]
      end

      Hash[*links.flatten]
    end

    def connection
      @connection ||= Faraday.new(:url => @api_url, :headers => headers) do |conn|
        conn.request :json
        conn.response :json

        conn.use SemaphoreClient::HttpClient::ResponseErrorMiddleware

        if @logger
          conn.response :logger, @logger, :headers => false, :bodies => true
        end

        conn.adapter Faraday.default_adapter
      end
    end

    def headers
      { "Authorization" => "Token #{@auth_token}" }
    end
  end
end
