class SemaphoreClient
  module Api
    class Secret
      def initialize(http_client)
        @http_client = http_client
      end


      def list_for_org(org_id, params = nil, options = {})
        list_for_org!(org_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def list_for_org!(org_id, params = nil, options = {})
        path = "/orgs/#{org_id}/secrets"

        @http_client.get(path, params, options = {}).body.map { |e| SemaphoreClient::Model::Secret.load(e) }
      end



      def create_for_org(org_id, params = nil, options = {})
        create_for_org!(org_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def create_for_org!(org_id, params = nil, options = {})
        path = "/orgs/#{org_id}/secrets"
        response = @http_client.post(path, params, options)

        SemaphoreClient::Model::Secret.load(response.body)
      end



      def list_for_team(team_id, params = nil, options = {})
        list_for_team!(team_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def list_for_team!(team_id, params = nil, options = {})
        path = "/teams/#{team_id}/secrets"

        @http_client.get(path, params, options = {}).body.map { |e| SemaphoreClient::Model::Secret.load(e) }
      end



      def attach_to_team(secret_id, team_id, params = nil, options = {})
        attach_to_team!(secret_id, team_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def attach_to_team!(secret_id, team_id, params = nil, options = {})
        path = "/teams/#{team_id}/secrets/#{secret_id}"

        @http_client.post(path, params, options)
      end



      def detach_from_team(secret_id, team_id, params = nil, options = {})
        detach_from_team!(secret_id, team_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def detach_from_team!(secret_id, team_id, params = nil, options = {})
        path = "/teams/#{team_id}/secrets/#{secret_id}"

        @http_client.delete(path, params, options)
      end



      def list_for_project(project_id, params = nil, options = {})
        list_for_project!(project_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def list_for_project!(project_id, params = nil, options = {})
        path = "/projects/#{project_id}/secrets"

        @http_client.get(path, params, options = {}).body.map { |e| SemaphoreClient::Model::Secret.load(e) }
      end



      def attach_to_project(secret_id, project_id, params = nil, options = {})
        attach_to_project!(secret_id, project_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def attach_to_project!(secret_id, project_id, params = nil, options = {})
        path = "/projects/#{project_id}/secrets/#{secret_id}"

        @http_client.post(path, params, options)
      end



      def detach_from_project(secret_id, project_id, params = nil, options = {})
        detach_from_project!(secret_id, project_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def detach_from_project!(secret_id, project_id, params = nil, options = {})
        path = "/projects/#{project_id}/secrets/#{secret_id}"

        @http_client.delete(path, params, options)
      end



      def get(id, params = nil, options = {})
        get!(id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def get!(id, params = nil, options = {})
        path = "/secrets/#{id}"
        response = @http_client.get(path, params = {})

        SemaphoreClient::Model::Secret.load(response.body)
      end



      def delete(id, params = nil, options = {})
        delete!(id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def delete!(id, params = nil, options = {})
        path = "/secrets/#{id}"

        @http_client.delete(path, params)
      end



      def update(id, params = nil, options = {})
        update!(id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def update!(id, params = nil, options = {})
        path = "/secrets/#{id}"
        response = @http_client.patch(path, params)

        SemaphoreClient::Model::Secret.load(response.body)
      end


    end
  end
end
