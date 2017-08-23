class SemaphoreClient
  module Api
    class User
      def initialize(http_client)
        @http_client = http_client
      end

      def list_for_org(org_id, query = nil)
        list_for_org!(org_id, query)
      rescue SemaphoreClient::Exceptions::RequestFailed
      end

      def list_for_team(team_id, query = nil)
        list_for_team!(team_id, query)
      rescue SemaphoreClient::Exceptions::RequestFailed
      end

      def attach_to_team(user_id, team_id)
        attach_to_team!(user_id, team_id)
      rescue SemaphoreClient::Exceptions::RequestFailed
      end

      def detach_from_team(user_id, team_id)
        detach_from_team!(user_id, team_id)
      rescue SemaphoreClient::Exceptions::RequestFailed
      end

      def list_for_project(project_id, query = nil)
        list_for_project!(project_id, query)
      rescue SemaphoreClient::Exceptions::RequestFailed
      end

      def list_for_org!(org_id, query = nil)
        query_string = query.nil? ? nil : "?#{query}"

        response = @http_client.get([:orgs, org_id, :users, query_string].compact)

        assert_response_status(response, 200)

        content = JSON.parse(response.body)

        content.map do |entity|
          SemaphoreClient::Model::User.load(entity)
        end
      end

      def list_for_team!(team_id, query = nil)
        query_string = query.nil? ? nil : "?#{query}"

        response = @http_client.get([:teams, team_id, :users, query_string].compact)

        assert_response_status(response, 200)

        content = JSON.parse(response.body)

        content.map do |entity|
          SemaphoreClient::Model::User.load(entity)
        end
      end

      def attach_to_team!(user_id, team_id)
        response = @http_client.post([:teams, team_id, :users, user_id])

        assert_response_status(response, 204)
      end

      def detach_from_team!(user_id, team_id)
        response = @http_client.delete([:teams, team_id, :users, user_id])

        assert_response_status(response, 204)
      end

      def list_for_project!(project_id, query = nil)
        query_string = query.nil? ? nil : "?#{query}"

        response = @http_client.get([:projects, project_id, :users, query_string].compact)

        assert_response_status(response, 200)

        content = JSON.parse(response.body)

        content.map do |entity|
          SemaphoreClient::Model::User.load(entity)
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
