# frozen_string_literal: true

begin
  require 'rails/railtie'
rescue LoadError
else
  class GobiertoValenciaEngine
    class Railtie < Rails::Railtie
      puts "Valencia railtie"
      base_path = File.join(File.dirname(__FILE__), "../..")
      Rails.application.config.tap do |conf|
        conf.assets.paths += [File.join(base_path, "app/assets/stylesheets"), File.join(base_path, "app/assets/images")]
        conf.engine_sass_config_overrides += ["themes/conf/_theme-valencia-conf"]
        conf.engine_sass_theme_dependencies += ["themes/_theme-valencia"]
        config.gobierto_engines_themes["gobierto-valencia-engine"] = "theme-valencia"
      end
      Webpacker::Compiler.watched_paths << "app/javascript/valencia/**/*.js"

      # Configure webservice delivery
      Rails.application.config.action_mailer.delivery_method = :webservice
      ::ActionMailer::Base.add_delivery_method :webservice, GobiertoValenciaEngine::ActionMailer::Base,
        wsdl: ENV["MAIL_WEBSERVICE_ADDRESS"]
    end
  end
end
