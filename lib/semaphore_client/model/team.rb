class SemaphoreClient
  module Model
    class Team
      attr_reader :projects_url, :updated_at, :id, :url, :shared_configs_url, :users_url, :created_at
      attr_accessor :name, :permission, :description

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
        @permission = attributes[:permission] if attributes.key?(:permission)
        @name = attributes[:name] if attributes.key?(:name)
        @updated_at = attributes[:updated_at] if attributes.key?(:updated_at)
        @id = attributes[:id] if attributes.key?(:id)
        @url = attributes[:url] if attributes.key?(:url)
        @shared_configs_url = attributes[:shared_configs_url] if attributes.key?(:shared_configs_url)
        @users_url = attributes[:users_url] if attributes.key?(:users_url)
        @created_at = attributes[:created_at] if attributes.key?(:created_at)

        self
      end

      def update(attributes)
        attributes = symbolize_keys(attributes)

        updatable_keys = [:name, :permission, :description]

        if (attributes.keys - updatable_keys).any?
          raise SemaphoreClient::Exceptions::AttributeNotAvailable
        end

        @name = attributes[:name] if attributes.key?(:name)
        @permission = attributes[:permission] if attributes.key?(:permission)
        @description = attributes[:description] if attributes.key?(:description)

        self
      end

      def serialize
        object_hash = {
          "name" => @name,
          "permission" => @permission,
          "description" => @description,
        }

        object_hash.delete_if { |_, value| value.nil? }
      end

      private

      def symbolize_keys(hash)
        hash.map { |key, value| [key.to_sym, value] }.to_h
      end
    end
  end
end
