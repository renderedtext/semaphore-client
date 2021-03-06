class SemaphoreClient
  module Model
    class Team
      attr_reader :id, :url, :users_url, :projects_url, :secrets_url, :updated_at, :created_at
      attr_accessor :name, :permission, :description

      def self.load(attributes)
        new.load(attributes)
      end

      def self.create(attributes)
        new.update(attributes)
      end

      def load(attributes)
        attributes = symbolize_keys(attributes)

        @name = attributes[:name] if attributes.key?(:name)
        @permission = attributes[:permission] if attributes.key?(:permission)
        @description = attributes[:description] if attributes.key?(:description)
        @id = attributes[:id] if attributes.key?(:id)
        @url = attributes[:url] if attributes.key?(:url)
        @users_url = attributes[:users_url] if attributes.key?(:users_url)
        @projects_url = attributes[:projects_url] if attributes.key?(:projects_url)
        @secrets_url = attributes[:secrets_url] if attributes.key?(:secrets_url)
        @updated_at = attributes[:updated_at] if attributes.key?(:updated_at)
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
        Hash[hash.map { |key, value| [key.to_sym, value] }]
      end
    end
  end
end
