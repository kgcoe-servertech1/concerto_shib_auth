module ConcertoShibAuth

  require 'omniauth'
  require 'omniauth-shibboleth'
  require 'concerto_identity'

  class Engine < ::Rails::Engine
    isolate_namespace ConcertoShibAuth
    engine_name 'concerto_shib_auth'

    # Define plugin information for the Concerto application to read.
    # Do not modify @plugin_info outside of this static configuration block.
    def plugin_info(plugin_info_class)
      @plugin_info ||= plugin_info_class.new do

        # Add our concerto_shib_auth route to the main application
        add_route("concerto_shib_auth", ConcertoShibAuth::Engine)

        # View hook to override Devise sign in links in the main application
        add_view_hook "ApplicationController", :signin_hook,
          :partial => "concerto_shib_auth/omniauth_shibboleth/signin"

      end
    end

  end
end
