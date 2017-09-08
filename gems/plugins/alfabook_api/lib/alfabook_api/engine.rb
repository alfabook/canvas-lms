module AlfabookApi
  class Engine < Rails::Engine
    initializer "alfabook_api.canvas_plugin" do
      require 'alfabook_api/openssl'
    end
  end
end
