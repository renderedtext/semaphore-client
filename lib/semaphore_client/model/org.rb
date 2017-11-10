class SemaphoreClient
  module Model
    class Org
      attr_reader :id, :name, :url, :projects_url, :secrets_url, :users_url, :teams_url, :username, :created_at, :updated_at

      def self.load(attributes)
        new.load(attributes)
      end

      def self.create(attributes)
        new.update(attributes)
      end

      def load(attributes)
        attributes = symbolize_keys(attributes)

        @id = attributes[:id] if attributes.key?(:id)
        @name = attributes[:name] if attributes.key?(:name)
        @url = attributes[:url] if attributes.key?(:url)
        @projects_url = attributes[:projects_url] if attributes.key?(:projects_url)
        @secrets_url = attributes[:secrets_url] if attributes.key?(:secrets_url)
        @users_url = attributes[:users_url] if attributes.key?(:users_url)
        @teams_url = attributes[:teams_url] if attributes.key?(:teams_url)
        @username = attributes[:username] if attributes.key?(:username)
        @created_at = attributes[:created_at] if attributes.key?(:created_at)
        @updated_at = attributes[:updated_at] if attributes.key?(:updated_at)

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
