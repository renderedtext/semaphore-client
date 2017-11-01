class SemaphoreClient
  module Api
    class EnvVar
      def initialize(http_client)
        @http_client = http_client
      end


      def list_for_project(project_id, params = nil, options = {})
        list_for_project!(project_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def list_for_project!(project_id, params = nil, options = {})
        path = "/projects/#{project_id}/env_vars"

        @http_client.get(path, params, options = {}).body.map { |e| SemaphoreClient::Model::EnvVar.load(e) }
      end



      def attach_to_project(env_var_id, project_id, params = nil, options = {})
        attach_to_project!(env_var_id, project_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def attach_to_project!(env_var_id, project_id, params = nil, options = {})
        path = "/projects/#{project_id}/env_vars/#{env_var_id}"

        @http_client.post(path, params, options)
      end



      def detach_from_project(env_var_id, project_id, params = nil, options = {})
        detach_from_project!(env_var_id, project_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def detach_from_project!(env_var_id, project_id, params = nil, options = {})
        path = "/projects/#{project_id}/env_vars/#{env_var_id}"

        @http_client.delete(path, params, options)
      end



      def list_for_secret(secret_id, params = nil, options = {})
        list_for_secret!(secret_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def list_for_secret!(secret_id, params = nil, options = {})
        path = "/secrets/#{secret_id}/env_vars"

        @http_client.get(path, params, options = {}).body.map { |e| SemaphoreClient::Model::EnvVar.load(e) }
      end



      def create_for_secret(secret_id, params = nil, options = {})
        create_for_secret!(secret_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def create_for_secret!(secret_id, params = nil, options = {})
        path = "/secrets/#{secret_id}/env_vars"
        response = @http_client.post(path, params, options)

        SemaphoreClient::Model::EnvVar.load(response.body)
      end



      def get(id, params = nil, options = {})
        get!(id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def get!(id, params = nil, options = {})
        path = "/env_vars/#{id}"
        response = @http_client.get(path, params = {})

        SemaphoreClient::Model::EnvVar.load(response.body)
      end



      def delete(id, params = nil, options = {})
        delete!(id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def delete!(id, params = nil, options = {})
        path = "/env_vars/#{id}"

        @http_client.delete(path, params)
      end



      def update(id, params = nil, options = {})
        update!(id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def update!(id, params = nil, options = {})
        path = "/env_vars/#{id}"
        response = @http_client.patch(path, params)

        SemaphoreClient::Model::EnvVar.load(response.body)
      end


    end
  end
end
