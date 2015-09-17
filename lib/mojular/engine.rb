module Mojular
  module Rails
    class Engine < ::Rails::Engine
      initializer 'mojular.assets.precompile' do |app|
        %w(scripts fonts images scss).each do |sub|
          app.config.assets.paths << root.join('bower_components', 'govuk-template', 'assets', sub).to_s
          app.config.assets.paths << root.join('assets', sub).to_s
        end
      end
    end
  end
end
