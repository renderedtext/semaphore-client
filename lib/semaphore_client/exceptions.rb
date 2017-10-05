class SemaphoreClient
  class Exceptions
    ApiError = Struct.new(:resource, :field, :code)

    class Base < StandardError; end

    class AttributeNotAvailable < Base; end

    class ResponseError < Base
      attr_reader :env

      def initialize(env)
        @env = env

        super(env[:message])
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
        JSON.parse(@env[:body])["erorrs"].map { |error| ApiError.new(error) }
      end
    end

    # 500+
    class ServerError < ResponseError; end
  end
end
