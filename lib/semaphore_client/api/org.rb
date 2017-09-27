class SemaphoreClient
  module Api
    class Org
      def initialize(http_client)
        @http_client = http_client
      end


      def list(params = nil, options = {})
        list!(params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def list!(params = nil, options = {})
        path = "/orgs"

        @http_client.get(path, params, options).body.map { |e| SemaphoreClient::Model::Org.load(e) }
      end



      def get(id, params = nil, options = {})
        get!(id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def get!(id, params = nil, options = {})
        path = "/orgs/#{id}"
        response = @http_client.get(path, params = {})

        SemaphoreClient::Model::Org.load(response.body)
      end


    end
  end
end
