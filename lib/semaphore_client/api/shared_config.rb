class SemaphoreClient
  module Api
    class SharedConfig
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

      def list_for_team(team_id, query = nil)
        list_for_team!(team_id, query)
      rescue SemaphoreClient::Exceptions::RequestFailed
      end

      def attach_to_team(shared_config_id, team_id)
        attach_to_team!(shared_config_id, team_id)
      rescue SemaphoreClient::Exceptions::RequestFailed
      end

      def detach_from_team(shared_config_id, team_id)
        detach_from_team!(shared_config_id, team_id)
      rescue SemaphoreClient::Exceptions::RequestFailed
      end

      def list_for_project(project_id, query = nil)
        list_for_project!(project_id, query)
      rescue SemaphoreClient::Exceptions::RequestFailed
      end

      def attach_to_project(shared_config_id, project_id)
        attach_to_project!(shared_config_id, project_id)
      rescue SemaphoreClient::Exceptions::RequestFailed
      end

      def detach_from_project(shared_config_id, project_id)
        detach_from_project!(shared_config_id, project_id)
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

      def list_for_org!(org_id, query = nil)
        query_string =
          unless query.nil? || query.empty?
            "?" + query.map { |key, value| "#{key}=#{value}" }.join("&")
          end

        response = @http_client.get([:orgs, org_id, :shared_configs, query_string].compact)

        assert_response_status(response, 200)

        content = JSON.parse(response.body)

        content.map do |entity|
          SemaphoreClient::Model::SharedConfig.load(entity)
        end
      end

      def create_for_org!(org_id, params)
        response = @http_client.post([:orgs, org_id, :shared_configs], params.to_json)

        assert_response_status(response, 200)

        content = JSON.parse(response.body)

        SemaphoreClient::Model::SharedConfig.load(content)
      end

      def list_for_team!(team_id, query = nil)
        query_string =
          unless query.nil? || query.empty?
            "?" + query.map { |key, value| "#{key}=#{value}" }.join("&")
          end

        response = @http_client.get([:teams, team_id, :shared_configs, query_string].compact)

        assert_response_status(response, 200)

        content = JSON.parse(response.body)

        content.map do |entity|
          SemaphoreClient::Model::SharedConfig.load(entity)
        end
      end

      def attach_to_team!(shared_config_id, team_id)
        response = @http_client.post([:teams, team_id, :shared_configs, shared_config_id])

        assert_response_status(response, 204)
      end

      def detach_from_team!(shared_config_id, team_id)
        response = @http_client.delete([:teams, team_id, :shared_configs, shared_config_id])

        assert_response_status(response, 204)
      end

      def list_for_project!(project_id, query = nil)
        query_string =
          unless query.nil? || query.empty?
            "?" + query.map { |key, value| "#{key}=#{value}" }.join("&")
          end

        response = @http_client.get([:projects, project_id, :shared_configs, query_string].compact)

        assert_response_status(response, 200)

        content = JSON.parse(response.body)

        content.map do |entity|
          SemaphoreClient::Model::SharedConfig.load(entity)
        end
      end

      def attach_to_project!(shared_config_id, project_id)
        response = @http_client.post([:projects, project_id, :shared_configs, shared_config_id])

        assert_response_status(response, 204)
      end

      def detach_from_project!(shared_config_id, project_id)
        response = @http_client.delete([:projects, project_id, :shared_configs, shared_config_id])

        assert_response_status(response, 204)
      end

      def get!(id)
        response = @http_client.get([:shared_configs, id])

        assert_response_status(response, 200)

        content = JSON.parse(response.body)

        SemaphoreClient::Model::SharedConfig.load(content)
      end

      def delete!(id)
        response = @http_client.delete([:shared_configs, id])

        assert_response_status(response, 200)
      end

      def update!(id, params)
        response = @http_client.patch([:shared_configs, id], params.to_json)

        assert_response_status(response, 200)

        content = JSON.parse(response.body)

        SemaphoreClient::Model::SharedConfig.load(content)
      end

      private

      def assert_response_status(response, expected_status)
        return if response.status == expected_status

        raise SemaphoreClient::Exceptions::RequestFailed, response.status
      end
    end
  end
end
