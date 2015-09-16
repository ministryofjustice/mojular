module Mojular
  module Rails
    class Engine < ::Rails::Engine
      initializer 'mojular.assets.precompile' do |app|
        %w(stylesheets javascripts fonts images).each do |sub|
          app.config.assets.paths << root.join('assets', sub).to_s
        end
        p 'REGISTERING RAILS'
        # app.config.assets.precompile << %r(bootstrap/glyphicons-halflings-regular\.(?:eot|svg|ttf|woff2?)$)
      end
    end
  end
end
