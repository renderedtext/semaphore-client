class SemaphoreClient
  class HttpClient
    class RouteNotSupported < StandardError; end

    def initialize(auth_token, api_url, api_version, verbose, logger)
      @auth_token = auth_token
      @api_url = api_url
      @api_version = api_version
      @verbose = verbose
      @logger = logger
    end

    def get(route_elements)
      route = route(route_elements)

      trace("GET", route) do
        connection.get(route)
      end
    end

    def post(route_elements, content = nil)
      route = route(route_elements)

      if content
        trace("POST", route, content) do
          connection.post(route, content)
        end
      else
        trace("POST", route) do
          connection.post(route)
        end
      end
    end

    def patch(route_elements, content = nil)
      route = route(route_elements)

      if content
        trace("PATCH", route, content) do
          connection.patch(route, content)
        end
      else
        trace("PATCH", route) do
          connection.patch(route)
        end
      end
    end

    def delete(route_elements)
      route = route(route_elements)

      trace("DELETE", route) do
        connection.delete(route)
      end
    end

    private

    def trace(method, path, content = nil)
      if @verbose == true
        id = SecureRandom.hex
        started_at = Time.now.to_f

        @logger.info "#{id} #{method} #{path} body: #{content.inspect}"
        response = yield

        finished_at = Time.now.to_f
        @logger.info "#{id} #{response.status} duration: #{finished_at - started_at}s body: #{response.body}"

        response
      else
        yield
      end
    end

    def route(route_elements)
      ["", @api_version, *route_elements].compact.join("/")
    end

    def connection
      @connection ||= Faraday.new(
        :url => @api_url,
        :headers => { "Authorization" => "Token #{@auth_token}" }
      )
    end
  end
end
