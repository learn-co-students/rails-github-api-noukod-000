class RepositoriesController < ApplicationController
  
  def index
    # binding.pry
    # session.delete('token')
    token = 'token ' + session[:token]
    user = Faraday.get('https://api.github.com/user') do |req|
      req.headers['Authorization'] = token
      req.headers['Accept'] = 'application/json'
    end

    @user = JSON.parse user.body
    repos = Faraday.get('https://api.github.com/user/repos') do |req|
      req.headers['Authorization'] = token
      req.headers['Accept'] = 'application/json'
    end

    @repo_info = JSON.parse repos.body
  end

end
