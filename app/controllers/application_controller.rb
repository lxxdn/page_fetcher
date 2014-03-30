class ApplicationController < ActionController::Base
  protect_from_forgery

  def has_access_token?
  	session[:access_token].present?
  end
end
