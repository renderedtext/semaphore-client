class SemaphoreClient
  module Model
    class ConfigFile
      attr_reader :id, :url, :shared, :encrypted, :created_at, :updated_at
      attr_accessor :path, :content

      def self.load(attributes)
        new.load(attributes)
      end

      def self.create(attributes)
        new.update(attributes)
      end

      def load(attributes)
        attributes = symbolize_keys(attributes)

        @id = attributes[:id] if attributes.key?(:id)
        @path = attributes[:path] if attributes.key?(:path)
        @url = attributes[:url] if attributes.key?(:url)
        @content = attributes[:content] if attributes.key?(:content)
        @shared = attributes[:shared] if attributes.key?(:shared)
        @encrypted = attributes[:encrypted] if attributes.key?(:encrypted)
        @created_at = attributes[:created_at] if attributes.key?(:created_at)
        @updated_at = attributes[:updated_at] if attributes.key?(:updated_at)

        self
      end

      def update(attributes)
        attributes = symbolize_keys(attributes)

        updatable_keys = [:path, :content]

        if (attributes.keys - updatable_keys).any?
          raise SemaphoreClient::Exceptions::AttributeNotAvailable
        end

        @path = attributes[:path] if attributes.key?(:path)
        @content = attributes[:content] if attributes.key?(:content)

        self
      end

      def serialize
        object_hash = {
          "path" => @path,
          "content" => @content,
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
