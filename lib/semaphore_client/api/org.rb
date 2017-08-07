class SemaphoreClient
  module Api
    class Org
      def initialize(http_client)
        @http_client = http_client
      end

      def list
        list!
      rescue SemaphoreClient::Exceptions::RequestFailed
      end

      def get(id)
        get!(id)
      rescue SemaphoreClient::Exceptions::RequestFailed
      end

      def list!
        response = @http_client.get([:orgs])

        assert_response_status(response, 200)

        content = JSON.parse(response.body)

        content.map do |entity|
          SemaphoreClient::Model::Org.load(entity)
        end
      end

      def get!(id)
        response = @http_client.get([:orgs, id])

        assert_response_status(response, 200)

        content = JSON.parse(response.body)

        SemaphoreClient::Model::Org.load(content)
      end

      private

      def assert_response_status(response, expected_status)
        return if response.status == expected_status

        raise SemaphoreClient::Exceptions::RequestFailed, response.status
      end
    end
  end
end
