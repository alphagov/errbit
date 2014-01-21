Devise.setup do |config|
  config.omniauth :gds,
    "insert oauth_id",
    "insert oauth_secret",
    :client_options => {
      :site => Plek.current.find('signon'),
      :authorize_url => "#{Plek.current.find('signon')}/oauth/authorize",
      :token_url => "#{Plek.current.find('signon')}/oauth/access_token",
    }
end
