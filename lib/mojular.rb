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
    end

    def register_rails_engine
      require 'mojular/engine'
    end

    def register_sprockets
      # Append assets paths
    end
  end
end

Mojular.load!
