class SemaphoreClient
  module Api
    class Project
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

      def attach_to_team(project_id, team_id)
        attach_to_team!(project_id, team_id)
      rescue SemaphoreClient::Exceptions::RequestFailed
      end

      def detach_from_team(project_id, team_id)
        detach_from_team!(project_id, team_id)
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

        response = @http_client.get([:orgs, org_id, :projects, query_string].compact)

        assert_response_status(response, 200)

        content = JSON.parse(response.body)

        content.map do |entity|
          SemaphoreClient::Model::Project.load(entity)
        end
      end

      def create_for_org!(org_id, params)
        response = @http_client.post([:orgs, org_id, :projects], params.to_json)

        assert_response_status(response, 200)

        content = JSON.parse(response.body)

        SemaphoreClient::Model::Project.load(content)
      end

      def list_for_team!(team_id, query = nil)
        query_string =
          unless query.nil? || query.empty?
            "?" + query.map { |key, value| "#{key}=#{value}" }.join("&")
          end

        response = @http_client.get([:teams, team_id, :projects, query_string].compact)

        assert_response_status(response, 200)

        content = JSON.parse(response.body)

        content.map do |entity|
          SemaphoreClient::Model::Project.load(entity)
        end
      end

      def attach_to_team!(project_id, team_id)
        response = @http_client.post([:teams, team_id, :projects, project_id])

        assert_response_status(response, 204)
      end

      def detach_from_team!(project_id, team_id)
        response = @http_client.delete([:teams, team_id, :projects, project_id])

        assert_response_status(response, 204)
      end

      def list_for_shared_config!(shared_config_id, query = nil)
        query_string =
          unless query.nil? || query.empty?
            "?" + query.map { |key, value| "#{key}=#{value}" }.join("&")
          end

        response = @http_client.get([:shared_configs, shared_config_id, :projects, query_string].compact)

        assert_response_status(response, 200)

        content = JSON.parse(response.body)

        content.map do |entity|
          SemaphoreClient::Model::Project.load(entity)
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
