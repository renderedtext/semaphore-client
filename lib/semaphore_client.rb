require "json"
require "securerandom"
require "faraday"
require "faraday_middleware"
require "logger"

require "semaphore_client/version"
require "semaphore_client/exceptions"
require "semaphore_client/http_client"
require "semaphore_client/model/user"
require "semaphore_client/model/org"
require "semaphore_client/model/team"
require "semaphore_client/model/project"
require "semaphore_client/model/secret"
require "semaphore_client/model/env_var"
require "semaphore_client/model/config_file"
require "semaphore_client/model/pipeline"
require "semaphore_client/api/user"
require "semaphore_client/api/org"
require "semaphore_client/api/team"
require "semaphore_client/api/project"
require "semaphore_client/api/secret"
require "semaphore_client/api/env_var"
require "semaphore_client/api/config_file"
require "semaphore_client/api/pipeline"

class SemaphoreClient
  API_URL = "https://api.semaphoreci.com"
  API_VERSION = "v2"

  def initialize(auth_token, options = {})
    @auth_token = auth_token

    @api_url       = options.fetch(:api_url, API_URL)
    @api_version   = options.fetch(:api_version, API_VERSION)
    @logger        = options.fetch(:logger, nil)
    @auto_paginate = options.fetch(:auto_paginate, false)
  end

  def users
    @user_api ||= SemaphoreClient::Api::User.new(http_client)
  end

  def orgs
    @org_api ||= SemaphoreClient::Api::Org.new(http_client)
  end

  def teams
    @team_api ||= SemaphoreClient::Api::Team.new(http_client)
  end

  def projects
    @project_api ||= SemaphoreClient::Api::Project.new(http_client)
  end

  def secrets
    @secret_api ||= SemaphoreClient::Api::Secret.new(http_client)
  end

  def env_vars
    @env_var_api ||= SemaphoreClient::Api::EnvVar.new(http_client)
  end

  def config_files
    @config_file_api ||= SemaphoreClient::Api::ConfigFile.new(http_client)
  end

  def pipelines
    @pipeline_api ||= SemaphoreClient::Api::Pipeline.new(http_client)
  end

  private

  def http_client
    @http_client ||= SemaphoreClient::HttpClient.new(@auth_token, @api_url, @api_version, @logger, @auto_paginate)
  end
end
