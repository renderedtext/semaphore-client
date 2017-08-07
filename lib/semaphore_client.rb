require "json"

require "semaphore_client/version"
require "semaphore_client/exceptions"
require "semaphore_client/http_client"
require "semaphore_client/model/user"
require "semaphore_client/model/org"
require "semaphore_client/model/team"
require "semaphore_client/model/project"
require "semaphore_client/model/shared_config"
require "semaphore_client/model/env_var"
require "semaphore_client/model/config_file"
require "semaphore_client/api/user"
require "semaphore_client/api/org"
require "semaphore_client/api/team"
require "semaphore_client/api/project"
require "semaphore_client/api/shared_config"
require "semaphore_client/api/env_var"
require "semaphore_client/api/config_file"

class SemaphoreClient
  API_URL = "https://api.semaphoreci.com"
  API_VERSION = "v2"

  def initialize(auth_token, api_url = API_URL, api_version = API_VERSION)
    @auth_token = auth_token
    @api_url = api_url
    @api_version = api_version
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

  def shared_configs
    @shared_config_api ||= SemaphoreClient::Api::SharedConfig.new(http_client)
  end

  def env_vars
    @env_var_api ||= SemaphoreClient::Api::EnvVar.new(http_client)
  end

  def config_files
    @config_file_api ||= SemaphoreClient::Api::ConfigFile.new(http_client)
  end

  private

  def http_client
    @http_client ||= SemaphoreClient::HttpClient.new(@auth_token, @api_url, @api_version)
  end
end
