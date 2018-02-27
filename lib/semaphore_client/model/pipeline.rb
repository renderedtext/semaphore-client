class SemaphoreClient
  module Model
    class Pipeline
      attr_reader :id
      attr_accessor :terminate_request

      def self.load(attributes)
        new.load(attributes)
      end

      def self.create(attributes)
        new.update(attributes)
      end

      def load(attributes)
        attributes = symbolize_keys(attributes)

        @id = attributes[:id] if attributes.key?(:id)

        self
      end

      def update(attributes)
        attributes = symbolize_keys(attributes)

        updatable_keys = [:terminate_request]

        if (attributes.keys - updatable_keys).any?
          raise SemaphoreClient::Exceptions::AttributeNotAvailable
        end

        @terminate_request = attributes[:terminate_request] if attributes.key?(:terminate_request)

        self
      end

      def serialize
        object_hash = {
          "terminate_request" => @terminate_request,
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
