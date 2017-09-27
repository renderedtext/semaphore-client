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



      def attach_to_project(config_file_id, project_id, params = nil, options = {})
        attach_to_project!(config_file_id, project_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def attach_to_project!(config_file_id, project_id, params = nil, options = {})
        path = "/projects/#{project_id}/config_files/#{config_file_id}"

        @http_client.post(path, params, options)
      end



      def detach_from_project(config_file_id, project_id, params = nil, options = {})
        detach_from_project!(config_file_id, project_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def detach_from_project!(config_file_id, project_id, params = nil, options = {})
        path = "/projects/#{project_id}/config_files/#{config_file_id}"

        @http_client.delete(path, params, options)
      end



      def list_for_shared_config(shared_config_id, params = nil, options = {})
        list_for_shared_config!(shared_config_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def list_for_shared_config!(shared_config_id, params = nil, options = {})
        path = "/shared_configs/#{shared_config_id}/config_files"

        @http_client.get(path, params, options = {}).body.map { |e| SemaphoreClient::Model::ConfigFile.load(e) }
      end



      def create_for_shared_config(shared_config_id, params = nil, options = {})
        create_for_shared_config!(shared_config_id, params, options)
      rescue SemaphoreClient::Exceptions::ResponseError
      end

      def create_for_shared_config!(shared_config_id, params = nil, options = {})
        path = "/shared_configs/#{shared_config_id}/config_files"
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
