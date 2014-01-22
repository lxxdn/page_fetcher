class SessionsController < ApplicationController
	def create
		session[:access_token] = request.env['omniauth.auth'][:credentials][:token]
		redirect_to root_path
	end
end
