class SemaphoreClient
  module Api
    class Team
      def initialize(http_client)
        @http_client = http_client
      end

      def list_for_org(org_id, query = nil)
        list_for_org!(org_id, query)
      rescue SemaphoreClient::Exceptions::RequestFailed
      end

      def create_for_org(org_id, params)
        create_for_org!(org_id, params)
      rescue SemaphoreClient::Exceptions::RequestFailed
      end

      def get(id)
        get!(id)
      rescue SemaphoreClient::Exceptions::RequestFailed
      end

      def delete(id)
        delete!(id)
      rescue SemaphoreClient::Exceptions::RequestFailed
      end

      def update(id, params)
        update!(id, params)
      rescue SemaphoreClient::Exceptions::RequestFailed
      end

      def list_for_project(project_id, query = nil)
        list_for_project!(project_id, query)
      rescue SemaphoreClient::Exceptions::RequestFailed
      end

      def list_for_shared_config(shared_config_id, query = nil)
        list_for_shared_config!(shared_config_id, query)
      rescue SemaphoreClient::Exceptions::RequestFailed
      end

      def list_for_org!(org_id, query = nil)
        query_string =
          unless query.nil? || query.empty?
            "?" + query.map { |key, value| "#{key}=#{value}" }.join("&")
          end

        response = @http_client.get([:orgs, org_id, :teams, query_string].compact)

        assert_response_status(response, 200)

        content = JSON.parse(response.body)

        content.map do |entity|
          SemaphoreClient::Model::Team.load(entity)
        end
      end

      def create_for_org!(org_id, params)
        response = @http_client.post([:orgs, org_id, :teams], params.to_json)

        assert_response_status(response, 200)

        content = JSON.parse(response.body)

        SemaphoreClient::Model::Team.load(content)
      end

      def get!(id)
        response = @http_client.get([:teams, id])

        assert_response_status(response, 200)

        content = JSON.parse(response.body)

        SemaphoreClient::Model::Team.load(content)
      end

      def delete!(id)
        response = @http_client.delete([:teams, id])

        assert_response_status(response, 200)
      end

      def update!(id, params)
        response = @http_client.patch([:teams, id], params.to_json)

        assert_response_status(response, 200)

        content = JSON.parse(response.body)

        SemaphoreClient::Model::Team.load(content)
      end

      def list_for_project!(project_id, query = nil)
        query_string =
          unless query.nil? || query.empty?
            "?" + query.map { |key, value| "#{key}=#{value}" }.join("&")
          end

        response = @http_client.get([:projects, project_id, :teams, query_string].compact)

        assert_response_status(response, 200)

        content = JSON.parse(response.body)

        content.map do |entity|
          SemaphoreClient::Model::Team.load(entity)
        end
      end

      def list_for_shared_config!(shared_config_id, query = nil)
        query_string =
          unless query.nil? || query.empty?
            "?" + query.map { |key, value| "#{key}=#{value}" }.join("&")
          end

        response = @http_client.get([:shared_configs, shared_config_id, :teams, query_string].compact)

        assert_response_status(response, 200)

        content = JSON.parse(response.body)

        content.map do |entity|
          SemaphoreClient::Model::Team.load(entity)
        end
      end

      private

      def assert_response_status(response, expected_status)
        return if response.status == expected_status

        raise SemaphoreClient::Exceptions::RequestFailed, response.status
      end
    end
  end
end
