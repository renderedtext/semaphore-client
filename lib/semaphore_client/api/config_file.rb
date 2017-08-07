class SemaphoreClient
  module Api
    class ConfigFile
      def initialize(http_client)
        @http_client = http_client
      end

      def list_for_project(project_id)
        list_for_project!(project_id)
      rescue SemaphoreClient::Exceptions::RequestFailed
      end

      def attach_to_project(config_file_id, project_id)
        attach_to_project!(config_file_id, project_id)
      rescue SemaphoreClient::Exceptions::RequestFailed
      end

      def detach_from_project(config_file_id, project_id)
        detach_from_project!(config_file_id, project_id)
      rescue SemaphoreClient::Exceptions::RequestFailed
      end

      def list_for_shared_config(shared_config_id)
        list_for_shared_config!(shared_config_id)
      rescue SemaphoreClient::Exceptions::RequestFailed
      end

      def create_for_shared_config(shared_config_id, params)
        create_for_shared_config!(shared_config_id, params)
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

      def list_for_project!(project_id)
        response = @http_client.get([:projects, project_id, :config_files])

        assert_response_status(response, 200)

        content = JSON.parse(response.body)

        content.map do |entity|
          SemaphoreClient::Model::ConfigFile.load(entity)
        end
      end

      def attach_to_project!(config_file_id, project_id)
        response = @http_client.post([:projects, project_id, :config_files, config_file_id])

        assert_response_status(response, 204)
      end

      def detach_from_project!(config_file_id, project_id)
        response = @http_client.delete([:projects, project_id, :config_files, config_file_id])

        assert_response_status(response, 204)
      end

      def list_for_shared_config!(shared_config_id)
        response = @http_client.get([:shared_configs, shared_config_id, :config_files])

        assert_response_status(response, 200)

        content = JSON.parse(response.body)

        content.map do |entity|
          SemaphoreClient::Model::ConfigFile.load(entity)
        end
      end

      def create_for_shared_config!(shared_config_id, params)
        response = @http_client.post([:shared_configs, shared_config_id, :config_files], params.to_json)

        assert_response_status(response, 200)

        content = JSON.parse(response.body)

        SemaphoreClient::Model::ConfigFile.load(content)
      end

      def get!(id)
        response = @http_client.get([:config_files, id])

        assert_response_status(response, 200)

        content = JSON.parse(response.body)

        SemaphoreClient::Model::ConfigFile.load(content)
      end

      def delete!(id)
        response = @http_client.delete([:config_files, id])

        assert_response_status(response, 200)
      end

      def update!(id, params)
        response = @http_client.patch([:config_files, id], params.to_json)

        assert_response_status(response, 200)

        content = JSON.parse(response.body)

        SemaphoreClient::Model::ConfigFile.load(content)
      end

      private

      def assert_response_status(response, expected_status)
        return if response.status == expected_status

        raise SemaphoreClient::Exceptions::RequestFailed, response.status
      end
    end
  end
end
