if ActiveRecord::Base.connection.table_exists? 'concerto_configs'
  # Concerto Configs are created if they don't exist already
  #   these are used to initialize and configure omniauth-shibboleth
  ConcertoConfig.make_concerto_config("shib_url", "https://shibboleth.main.ad.rit.edu/idp/Authn/UserPassword",
    :value_type => "string",
    :value_default => "https://shibboleth.main.ad.rit.edu/idp/Authn/UserPassword",
    :category => "Shibboleth User Authentication",
    :seq_no => 1,
    :description =>"Defines the url of your Shibboleth server")

  ConcertoConfig.make_concerto_config("shib_uid_key", "uid",
    :value_type => "string",
    :category => "Shibboleth User Authentication",
    :seq_no => 2,
    :description => "Shibboleth field name containing user login names")

  ConcertoConfig.make_concerto_config("shib_email_key", "email",
    :value_type => "string",
    :category => "Shibboleth User Authentication",
    :seq_no => 3,
    :description => "Shibboleth field name containing user email addresses")

  ConcertoConfig.make_concerto_config("shib_email_suffix", "@",
    :value_type => "string",
    :category => "Shibboleth User Authentication",
    :seq_no => 4,
    :description => "Appends this suffix to a Shibboleth returned user id. Leave blank if using email_key above")

  ConcertoConfig.make_concerto_config("shib_first_name_key", "first_name",
    :value_type => "string",
    :category => "Shibboleth User Authentication",
    :seq_no => 5,
    :description => "Shibboleth field name containing first name")

  # Store omniauth config values from main application's ConcertoConfig
  omniauth_config = {
    :host => URI.parse(ConcertoConfig[:shib_url]).host,
    :url => ConcertoConfig[:shib_url],
    :uid_key => ConcertoConfig[:shib_uid_key],
    :first_name_key => ConcertoConfig[:shib_first_name_key],
    :email_key => ConcertoConfig[:shib_email_key],
    :email_suffix => ConcertoConfig[:shib_email_suffix],
    :callback_url => "/auth/shib/callback"
  }

  # configure omniauth-shib gem based on specified yml configs
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :shibboleth, omniauth_config
  end

  # save omniauth configuration for later use in application
  #  to reference any unique identifiers for extra shib options
  ConcertoShibAuth::Engine.configure do
     config.omniauth_keys = omniauth_config
  end
end
