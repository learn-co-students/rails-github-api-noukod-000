class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
      req.body = { 'client_id': ENV['GITHUB_CLIENT'], 'client_secret': ENV['GITHUB_SECRET'], 'code': params['code']  }
      req.headers['Accept'] = 'application/json'
    end

    body = JSON.parse(response.body)
    # resp = Faraday.get("https://github.com/oauth2/access_token") do |req|
    #   req.params['client_id'] = ENV['github_CLIENT_ID']
    #   req.params['client_secret'] = ENV['github_SECRET']
    #   req.params['grant_type'] = 'authorization_code'
    #   req.params['redirect_uri'] = "http://localhost:3000/auth"
    #   req.params['code'] = params[:code]
    # end
   
    # body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end
# client_id = ENV['GITHUB_CLIENT_ID']
#     redirect_uri = CGI.escape("http://localhost:3000/auth")
#     github_url = "https://github.com/login/oauth/authorize?client_id=#{client_id}"
#     redirect_to github_url unless logged_in?