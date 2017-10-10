class SemaphoreClient
  class Exceptions
    ApiError = Struct.new(:resource, :field, :code)

    class Base < StandardError; end

    class AttributeNotAvailable < Base; end

    class ResponseError < Base
      attr_reader :env

      def initialize(env)
        @env = env

        super(message)
      end

      def code
        @env[:status]
      end

      def message
        body["message"] if body.is_a?(Hash)
      end

      def body
        JSON.parse(@env[:body])
      end
    end

    # 400
    class BadRequest < ResponseError; end

    # 401
    class Unauthorized < ResponseError; end

    # 404
    class NotFound < ResponseError; end

    # 405
    class NotAllowed < ResponseError; end

    # 409
    class Conflict < ResponseError; end

    # 422
    class UnprocessableEntity < ResponseError
      def errors
        JSON.parse(@env[:body])["errors"].map do |error|
          ApiError.new(error["resource"], error["field"], error["code"])
        end
      end
    end

    # 500+
    class ServerError < ResponseError; end
  end
end
