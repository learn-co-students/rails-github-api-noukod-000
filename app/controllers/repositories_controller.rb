class RepositoriesController < ApplicationController


  def index
    resp=Faraday.get "https://api.github.com/user" do |req|
      req.headers['Authorization']= 'token '+ session[:token]
      req.headers['Accept']='application/json'
    end
    body=JSON.parse(resp.body)
    @username = body["login"]

    resp1=Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers['Authorization']= 'token '+ session[:token]
      req.headers['Accept']='application/json'
    end

    @repos=JSON.parse(resp1.body)
  end


end
