class SemaphoreClient
  module Model
    class SharedConfig
      attr_reader :projects_url, :teams_url, :config_files_url, :updated_at, :env_vars_url, :id, :url, :created_at
      attr_accessor :name, :description

      def self.load(attributes)
        new.load(attributes)
      end

      def self.create(attributes)
        new.update(attributes)
      end

      def load(attributes)
        attributes = symbolize_keys(attributes)

        @description = attributes[:description] if attributes.key?(:description)
        @projects_url = attributes[:projects_url] if attributes.key?(:projects_url)
        @teams_url = attributes[:teams_url] if attributes.key?(:teams_url)
        @name = attributes[:name] if attributes.key?(:name)
        @config_files_url = attributes[:config_files_url] if attributes.key?(:config_files_url)
        @updated_at = attributes[:updated_at] if attributes.key?(:updated_at)
        @env_vars_url = attributes[:env_vars_url] if attributes.key?(:env_vars_url)
        @id = attributes[:id] if attributes.key?(:id)
        @url = attributes[:url] if attributes.key?(:url)
        @created_at = attributes[:created_at] if attributes.key?(:created_at)

        self
      end

      def update(attributes)
        attributes = symbolize_keys(attributes)

        updatable_keys = [:name, :description]

        if (attributes.keys - updatable_keys).any?
          raise SemaphoreClient::Exceptions::AttributeNotAvailable
        end

        @name = attributes[:name] if attributes.key?(:name)
        @description = attributes[:description] if attributes.key?(:description)

        self
      end

      def serialize
        object_hash = {
          "name" => @name,
          "description" => @description,
        }

        object_hash.delete_if { |_, value| value.nil? }
      end

      private

      def symbolize_keys(hash)
        Hash[hash.map { |key, value| [key.to_sym, value] }]
      end
    end
  end
end
