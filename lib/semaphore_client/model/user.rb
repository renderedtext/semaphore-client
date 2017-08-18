class SemaphoreClient
  module Model
    class User
      attr_reader :uid, :username, :name, :created_at, :updated_at

      def self.load(attributes)
        new.load(attributes)
      end

      def self.create(attributes)
        new.update(attributes)
      end

      def load(attributes)
        attributes = symbolize_keys(attributes)

        @uid = attributes[:uid] if attributes.key?(:uid)
        @username = attributes[:username] if attributes.key?(:username)
        @name = attributes[:name] if attributes.key?(:name)
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
