class SemaphoreClient
  module Api
    class ConfigFile
      def initialize(http_client)
        @http_client = http_client
      end


      def list_for_project(project_id, params = nil, options = {})
        list_for_project!(project_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def list_for_project!(project_id, params = nil, options = {})
        path = "/projects/#{project_id}/config_files"

        @http_client.get(path, params, options = {}).body.map { |e| SemaphoreClient::Model::ConfigFile.load(e) }
      end



      def list_for_secret(secret_id, params = nil, options = {})
        list_for_secret!(secret_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def list_for_secret!(secret_id, params = nil, options = {})
        path = "/secrets/#{secret_id}/config_files"

        @http_client.get(path, params, options = {}).body.map { |e| SemaphoreClient::Model::ConfigFile.load(e) }
      end



      def create_for_secret(secret_id, params = nil, options = {})
        create_for_secret!(secret_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def create_for_secret!(secret_id, params = nil, options = {})
        path = "/secrets/#{secret_id}/config_files"
        response = @http_client.post(path, params, options)

        SemaphoreClient::Model::ConfigFile.load(response.body)
      end



      def get(id, params = nil, options = {})
        get!(id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def get!(id, params = nil, options = {})
        path = "/config_files/#{id}"
        response = @http_client.get(path, params = {})

        SemaphoreClient::Model::ConfigFile.load(response.body)
      end



      def delete(id, params = nil, options = {})
        delete!(id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def delete!(id, params = nil, options = {})
        path = "/config_files/#{id}"

        @http_client.delete(path, params)
      end



      def update(id, params = nil, options = {})
        update!(id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def update!(id, params = nil, options = {})
        path = "/config_files/#{id}"
        response = @http_client.patch(path, params)

        SemaphoreClient::Model::ConfigFile.load(response.body)
      end


    end
  end
end
