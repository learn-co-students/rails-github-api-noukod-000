class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
  req.body = { 'client_id': '28a1c807579871e3858e', 'client_secret':'58640d2730665771dc3f23eec31041dc4433032d' 'code': code }
  req.headers['Accept'] = 'application/json'
   end
   body = JSON.parse(response.body)
  end
end
