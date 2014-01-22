Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.configuration.fb_app["app_id"], Rails.configuration.fb_app["app_secret"],
           :scope => 'publish_stream,email, user_status, read_stream'
end