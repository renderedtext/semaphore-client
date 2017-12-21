class SemaphoreClient
  module Model
    class Project
      attr_reader :id, :name, :html_url, :users_url, :secrets_url, :updated_at, :created_at

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
        @html_url = attributes[:html_url] if attributes.key?(:html_url)
        @users_url = attributes[:users_url] if attributes.key?(:users_url)
        @secrets_url = attributes[:secrets_url] if attributes.key?(:secrets_url)
        @updated_at = attributes[:updated_at] if attributes.key?(:updated_at)
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
