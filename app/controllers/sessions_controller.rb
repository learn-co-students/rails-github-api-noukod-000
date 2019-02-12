class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    # raise params.inspect
    if ENV['GITHUB_STATE'] == params[:state]
      # binding.pry
      #request for the acces_token
      @res = Faraday.post('https://github.com/login/oauth/access_token') do |req|
        req.body = { 'client_id': ENV['GTIHUB_CLIENT_ID'], 'client_secret': ENV['GTIHUB_CLIENT_SECRET'],
           'code': params[:code]  }
        req.headers['Accept'] = "application/json"
      end

      bodyToken = JSON.parse(@res.body)
      
      #if code matched github generate code
      unless bodyToken['error']
        session['token'] = bodyToken['access_token']
      else
        @error = bodyToken['error_description']
      end
    else
      @error = 'hacker u"ve failed'
    end

    redirect_to root_path
  end
end
