module Mojular
  module Rails
    class Engine < ::Rails::Engine
      initializer 'mojular.assets.precompile' do |app|
        app.config.assets.paths << root.join('assets')

        %w(fonts images scss).each do |path|
          app.config.assets.paths << root.join('assets', path).to_s
          app.config.assets.paths << root.join('bower_components', 'govuk-template', 'assets', path).to_s
        end

        begin
          import_paths = JSON.parse(IO.read("#{root.to_s}/bower_components/govuk-template/bower.json"))['importPaths']
          import_paths.each do |path|
            app.config.assets.paths << root.join('bower_components', path).to_s
          end
        rescue
        end

        app.config.assets.precompile += %w(*.js *.png *.jpg *.ico)
      end
    end
  end
end
