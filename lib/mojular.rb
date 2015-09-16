require 'mojular/version'

module Mojular
  class << self
    def load!
      if defined?(::Rails)
        register_rails_engine
      elsif defined?(::Sprockets)
        register_sprockets
      end

      configure_sass
    end

    def configure_sass
      require 'sass'

      # ::Sass.load_paths << stylesheets_path

      p 'CONFIGURING SASS...'

      # bootstrap requires minimum precision of 8, see https://github.com/twbs/bootstrap-sass/issues/409
      # ::Sass::Script::Number.precision = [8, ::Sass::Script::Number.precision].max
    end

    def register_rails_engine
      require 'mojular/engine'
    end

    def register_sprockets
      p 'REGISTERING SPROCKETS'
      # Sprockets.append_path(stylesheets_path)
      # Sprockets.append_path(fonts_path)
      # Sprockets.append_path(javascripts_path)
    end
  end
end

Mojular.load!
