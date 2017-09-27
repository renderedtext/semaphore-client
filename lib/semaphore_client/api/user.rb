class SemaphoreClient
  module Api
    class User
      def initialize(http_client)
        @http_client = http_client
      end


      def list_for_org(org_id, params = nil, options = {})
        list_for_org!(org_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def list_for_org!(org_id, params = nil, options = {})
        path = "/orgs/#{org_id}/users"

        @http_client.get(path, params, options = {}).body.map { |e| SemaphoreClient::Model::User.load(e) }
      end



      def list_for_team(team_id, params = nil, options = {})
        list_for_team!(team_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def list_for_team!(team_id, params = nil, options = {})
        path = "/teams/#{team_id}/users"

        @http_client.get(path, params, options = {}).body.map { |e| SemaphoreClient::Model::User.load(e) }
      end



      def attach_to_team(user_id, team_id, params = nil, options = {})
        attach_to_team!(user_id, team_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def attach_to_team!(user_id, team_id, params = nil, options = {})
        path = "/teams/#{team_id}/users/#{user_id}"

        @http_client.post(path, params, options)
      end



      def detach_from_team(user_id, team_id, params = nil, options = {})
        detach_from_team!(user_id, team_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def detach_from_team!(user_id, team_id, params = nil, options = {})
        path = "/teams/#{team_id}/users/#{user_id}"

        @http_client.delete(path, params, options)
      end



      def list_for_project(project_id, params = nil, options = {})
        list_for_project!(project_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def list_for_project!(project_id, params = nil, options = {})
        path = "/projects/#{project_id}/users"

        @http_client.get(path, params, options = {}).body.map { |e| SemaphoreClient::Model::User.load(e) }
      end


    end
  end
end
