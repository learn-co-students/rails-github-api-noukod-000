class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user

  private

  def authenticate_user
    puts "THEY SEE ME ROLLING, THE HATIN"
    redirect_uri=CGI.escape("http://159.89.225.105:37950/auth")
    client_id=ENV["GITHUB_CLIENT_ID"]
    client_secret=ENV["GITHUB_CLIENT_SECRET"]

    auth_url="https://github.com/login/oauth/authorize?client_id=#{client_id}&redirect_uri=#{redirect_uri}"
    redirect_to auth_url unless logged_in?
  end

  def logged_in?
    !!session[:token]
  end
end
