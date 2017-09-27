class SemaphoreClient
  module Api
    class Team
      def initialize(http_client)
        @http_client = http_client
      end


      def list_for_org(org_id, params = nil, options = {})
        list_for_org!(org_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def list_for_org!(org_id, params = nil, options = {})
        path = "/orgs/#{org_id}/teams"

        @http_client.get(path, params, options = {}).body.map { |e| SemaphoreClient::Model::Team.load(e) }
      end



      def create_for_org(org_id, params = nil, options = {})
        create_for_org!(org_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def create_for_org!(org_id, params = nil, options = {})
        path = "/orgs/#{org_id}/teams"
        response = @http_client.post(path, params, options)

        SemaphoreClient::Model::Team.load(response.body)
      end



      def get(id, params = nil, options = {})
        get!(id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def get!(id, params = nil, options = {})
        path = "/teams/#{id}"
        response = @http_client.get(path, params = {})

        SemaphoreClient::Model::Team.load(response.body)
      end



      def delete(id, params = nil, options = {})
        delete!(id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def delete!(id, params = nil, options = {})
        path = "/teams/#{id}"

        @http_client.delete(path, params)
      end



      def update(id, params = nil, options = {})
        update!(id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def update!(id, params = nil, options = {})
        path = "/teams/#{id}"
        response = @http_client.patch(path, params)

        SemaphoreClient::Model::Team.load(response.body)
      end



      def list_for_project(project_id, params = nil, options = {})
        list_for_project!(project_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def list_for_project!(project_id, params = nil, options = {})
        path = "/projects/#{project_id}/teams"

        @http_client.get(path, params, options = {}).body.map { |e| SemaphoreClient::Model::Team.load(e) }
      end



      def list_for_shared_config(shared_config_id, params = nil, options = {})
        list_for_shared_config!(shared_config_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def list_for_shared_config!(shared_config_id, params = nil, options = {})
        path = "/shared_configs/#{shared_config_id}/teams"

        @http_client.get(path, params, options = {}).body.map { |e| SemaphoreClient::Model::Team.load(e) }
      end


    end
  end
end
