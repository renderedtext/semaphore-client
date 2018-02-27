class SemaphoreClient
  module Api
    class Pipeline
      def initialize(http_client)
        @http_client = http_client
      end


      def list(params = nil, options = {})
        list!(params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def list!(params = nil, options = {})
        path = "/pipelines"

        @http_client.get(path, params, options).body.map { |e| SemaphoreClient::Model::Pipeline.load(e) }
      end



      def create(params = nil, options = {})
        create!(params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def create!(params = nil, options = {})
        path = "/pipelines"
        response = @http_client.post(path, params, options)

        SemaphoreClient::Model::Pipeline.load(response.body)
      end



      def get(id, params = nil, options = {})
        get!(id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def get!(id, params = nil, options = {})
        path = "/pipelines/#{id}"
        response = @http_client.get(path, params = {})

        SemaphoreClient::Model::Pipeline.load(response.body)
      end



      def update(id, params = nil, options = {})
        update!(id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def update!(id, params = nil, options = {})
        path = "/pipelines/#{id}"
        response = @http_client.patch(path, params)

        SemaphoreClient::Model::Pipeline.load(response.body)
      end


    end
  end
end
