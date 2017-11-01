class SemaphoreClient
  module Model
    class Org
      attr_reader :projects_url, :teams_url, :name, :secrets_url, :username, :updated_at, :id, :url, :users_url, :created_at

      def self.load(attributes)
        new.load(attributes)
      end

      def self.create(attributes)
        new.update(attributes)
      end

      def load(attributes)
        attributes = symbolize_keys(attributes)

        @projects_url = attributes[:projects_url] if attributes.key?(:projects_url)
        @teams_url = attributes[:teams_url] if attributes.key?(:teams_url)
        @name = attributes[:name] if attributes.key?(:name)
        @secrets_url = attributes[:secrets_url] if attributes.key?(:secrets_url)
        @username = attributes[:username] if attributes.key?(:username)
        @updated_at = attributes[:updated_at] if attributes.key?(:updated_at)
        @id = attributes[:id] if attributes.key?(:id)
        @url = attributes[:url] if attributes.key?(:url)
        @users_url = attributes[:users_url] if attributes.key?(:users_url)
        @created_at = attributes[:created_at] if attributes.key?(:created_at)

        self
      end

      def update(attributes)
        self
      end

      def serialize
        {}
      end

      private

      def symbolize_keys(hash)
        Hash[hash.map { |key, value| [key.to_sym, value] }]
      end
    end
  end
end
