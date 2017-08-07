require "faraday"

class SemaphoreClient
  class HttpClient
    class RouteNotSupported < StandardError; end

    def initialize(auth_token, api_url, api_version)
      @auth_token = auth_token
      @api_url = api_url
      @api_version = api_version
    end

    def get(route_elements)
      route = route(route_elements)

      connection.get(route)
    end

    def post(route_elements, content = nil)
      route = route(route_elements)

      if content
        connection.post(route, content)
      else
        connection.post(route)
      end
    end

    def patch(route_elements, content = nil)
      route = route(route_elements)

      if content
        connection.patch(route, content)
      else
        connection.patch(route)
      end
    end

    def delete(route_elements)
      route = route(route_elements)

      connection.delete(route)
    end

    private

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
