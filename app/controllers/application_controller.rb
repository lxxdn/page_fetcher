class ApplicationController < ActionController::Base
  protect_from_forgery

  def has_access_token?
  	not session[:access_token].nil?
  end
end
