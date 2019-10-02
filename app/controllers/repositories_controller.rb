class RepositoriesController < ApplicationController
  
  def index
    user = Faraday.get 'https://api.github.com/user' do |req|
      req.headers['Authorization'] =  'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end

    repos = Faraday.get 'https://api.github.com/user/repos' do |req|
      req.headers['Authorization'] =  'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end
      @user_name = JSON.parse(user.body)["login"]
      @repositories = JSON.parse(repos.body)
    end

    def create
      request = Faraday.post 'https://api.github.com/user/repos' do |req|
        debugger;
        req.headers['Authorization'] =  'token ' + session[:token]
        req.headers['Accept'] = 'application/json'
        req.params['name'] = params[:name]
      end
      redirect_to '/'

    end

end