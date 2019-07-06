class RepositoriesController < ApplicationController

  def index
    resp1 = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session['token']}"
      req.headers['Accept'] = 'application/json'
    end
    @user = JSON.parse(resp1.body)['login']

    resp2 = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session['token']}"
      req.headers['Accept'] = 'application/json'
    end

    @repos = JSON.parse(resp2.body)
  end

end
