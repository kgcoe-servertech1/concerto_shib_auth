Concerto::Application.routes.draw do
  get "/auth/shibboleth/callback", :to => "concerto_shib_auth/omniauth_callback#shib_auth"
end