class Facebook
	include HTTParty
	base_uri 'graph.facebook.com:443'

	def self.validate_identity(identity)
		response = JSON.parse(self.get("/#{identity}").body)
		response['error'].nil?
	end

	def self.get_user_info(identity)
		response = JSON.parse(self.get("/#{identity}?fields=id,name,picture").body)
		{identity: identity, name: response['name'], image_url: response['picture']['data']['url']}
	end

	# this function will get num feeds which have message attributes
	# To have a good performance, it gets 10 feeds each time.
	# Then it will filter the feeds which have message attributes
	# When it has gotten 10 feeds, it will get out of the loop
	def self.get_feeds(identity, access_token, num=10)
		url = "/#{identity}/feed?limit=#{num}&access_token=#{access_token}"
		user_feeds = []
		while user_feeds.length <10
			response = JSON.parse(self.get(url).body)
			feeds = response['data']
			break if feeds.blank?
			user_feeds += feeds.reject{|f| f['message'].nil? }
			user_feeds = user_feeds.take(num)
			url = response['paging']['next']+"&access_token=#{access_token}"
		end
		user_feeds
	end
end
