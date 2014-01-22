class FacebookUsersController < ApplicationController

	before_filter :require_token, :only => [:create, :feeds]

	def index
		@facebook_user = FacebookUser.new
	end

	def create
		identity = params[:facebook_user][:identity]
		if FacebookUser.find_by_identity(identity).nil?
			if (Facebook.validate_identity(identity))
	  		@fb_user = FacebookUser.new(Facebook.get_user_info(identity))
	  		@fb_user.save
	  	else
	  		flash[:error] = "The identity is invalid"
	  	end
	  else
	  	flash[:error] = "The user existed!"
	  end
  	redirect_to root_path
	end

	def feeds
		identity = FacebookUser.find(params[:id]).identity
		@feed_owner = Facebook.get_user_info(identity)
		feeds = Facebook.get_feeds(identity,session[:access_token])
		@feeds = []
		feeds.each do |feed|
			from_user = Facebook.get_user_info(feed['from']['id'])
			timestamp = DateTime.parse(feed['created_time']).to_time.to_i
			@feeds.push({from_image_url: from_user[:image_url], from_name: from_user[:name], message: feed['message'], created_at: timestamp})
		end
	end

	private
 
  def require_token
    unless has_access_token?
      flash[:error] = "You must connect with Facebook to get the access token"
      redirect_to "/auth/facebook"
    end
  end
end
