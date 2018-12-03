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
      end
      Webpacker::Compiler.watched_paths << "app/javascript/valencia/**/*.js"
    end
  end
end
