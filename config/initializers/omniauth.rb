Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env == 'production'
    # facebook app pointing to production environment (e.g. heroku)
    provider :facebook, ENV['MS_FB_KEY'], ENV['MS_FB_SECRET']
  else
    # facebook app pointing to 'localhost'
    provider :facebook, ENV['MS_FB_LOCAL_KEY'], ENV['MS_FB_LOCAL_SECRET']
  end
end