class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
      # binding.pry
      client_id, client_secret = ENV['GTIHUB_CLIENT_ID'], ENV['GTIHUB_CLIENT_SECRET']
      code = params['code']
      #request for the acces_token
      res = Faraday.post('https://github.com/login/oauth/access_token') do |req|
        # req.body = { 'client_id': client_id, 'client_secret': client_secret, 'code': code }.to_json
        req.headers['Accept'] = 'application/json'
      end

      bodyToken = JSON.parse(res.body)
      
      #if code matched the github generated code
      # unless bodyToken['error']
        session['token'] = bodyToken['access_token']
      # else
      #   @error = bodyToken['error_description']
      # end

      redirect_to root_path
  end
end
