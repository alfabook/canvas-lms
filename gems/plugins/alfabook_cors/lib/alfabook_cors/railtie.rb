require 'rack/cors'

module AlfabookCors
  class Railtie < Rails::Railtie
    initializer('alfabook_extend_middleware_stack', after: 'load_config_initializers') do |app|
      app.config.middleware.insert_before 0, 'Rack::Cors', :debug => ENV['network_cors_debug'], :logger => (-> { Rails.logger }) do
        allow do
          #Rails.logger.debug "AlfabookCors allowing #{ENV['network_cors_allow']}"
          origins Regexp.compile(ENV['network_cors_allow'])
          resource '*', headers: :any, methods: :any
        end
      end
    end
  end
end






