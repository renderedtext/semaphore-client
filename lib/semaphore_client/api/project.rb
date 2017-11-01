class SemaphoreClient
  module Api
    class Project
      def initialize(http_client)
        @http_client = http_client
      end


      def list_for_org(org_id, params = nil, options = {})
        list_for_org!(org_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def list_for_org!(org_id, params = nil, options = {})
        path = "/orgs/#{org_id}/projects"

        @http_client.get(path, params, options = {}).body.map { |e| SemaphoreClient::Model::Project.load(e) }
      end



      def create_for_org(org_id, params = nil, options = {})
        create_for_org!(org_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def create_for_org!(org_id, params = nil, options = {})
        path = "/orgs/#{org_id}/projects"
        response = @http_client.post(path, params, options)

        SemaphoreClient::Model::Project.load(response.body)
      end



      def list_for_team(team_id, params = nil, options = {})
        list_for_team!(team_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def list_for_team!(team_id, params = nil, options = {})
        path = "/teams/#{team_id}/projects"

        @http_client.get(path, params, options = {}).body.map { |e| SemaphoreClient::Model::Project.load(e) }
      end



      def attach_to_team(project_id, team_id, params = nil, options = {})
        attach_to_team!(project_id, team_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def attach_to_team!(project_id, team_id, params = nil, options = {})
        path = "/teams/#{team_id}/projects/#{project_id}"

        @http_client.post(path, params, options)
      end



      def detach_from_team(project_id, team_id, params = nil, options = {})
        detach_from_team!(project_id, team_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def detach_from_team!(project_id, team_id, params = nil, options = {})
        path = "/teams/#{team_id}/projects/#{project_id}"

        @http_client.delete(path, params, options)
      end



      def list_for_secret(secret_id, params = nil, options = {})
        list_for_secret!(secret_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def list_for_secret!(secret_id, params = nil, options = {})
        path = "/secrets/#{secret_id}/projects"

        @http_client.get(path, params, options = {}).body.map { |e| SemaphoreClient::Model::Project.load(e) }
      end


    end
  end
end
