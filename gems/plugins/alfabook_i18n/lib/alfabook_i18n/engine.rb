module AlfabookI18n
  class Engine < Rails::Engine
    config.autoload_paths << File.expand_path(File.join(__FILE__, '..'))
    # I18n.load_path += Dir.glob(File.join(File.dirname(__FILE__),  '../config/locales/*.yml'))

    config.to_prepare do
      # require_dependency 'alfabook_i18n/concerns/application_helper_with_translations'
    end

    # config.after_initialize do
    # end
  end
end
