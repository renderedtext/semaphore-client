class SemaphoreClient
  class Exceptions
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
    class UnprocessableEntity < ResponseError; end

    # 500+
    class ServerError < ResponseError; end
  end
end
