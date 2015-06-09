require 'travis/pro'
require 'travis/tools/github'
class BuildStateQuery
  def initialize(branch_name, repo_name)
    authenticate_to_travis
    @repo = get_repo(repo_name)
    @branch_name = branch_name
  end

  def status
    @repo.branch(@branch_name).color
  end

  private

  def authenticate_to_travis
    Travis::Pro.github_auth(ENV['GITHUB_TOKEN'])
  end

  def get_repo(repo_name)
    Travis::Pro::Repository.find(repo_name)
  end
end
