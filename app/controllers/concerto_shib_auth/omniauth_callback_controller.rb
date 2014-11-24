require_dependency "concerto_shib_auth/application_controller"

module ConcertoShibAuth
  class OmniauthCallbackController < ApplicationController

    def shib_auth
      shib_hash = request.env["omniauth.auth"]
      user = find_from_omniauth(shib_hash)

      if !user
        # Redirect showing flash notice with errors
        redirect_to "/"
      elsif user.persisted?
        flash.notice = "Signed in through Shibboleth"
        session["devise.user_attributes"] = user.attributes
        sign_in user
        redirect_to "/"
      else 
        flash.notice = "Signed in through Shibboleth"
        session["devise.user_attributes"] = user.attributes
        sign_in user
        redirect_to "/"
      end
    end

  end
end