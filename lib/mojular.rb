require 'mojular/version'
require 'json'

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

    def gem_path
      @gem_path ||= File.expand_path('..', File.dirname(__FILE__))
    end

    def configure_sass
      require 'sass'
    end

    def register_rails_engine
      require 'mojular/engine'
    end

    def register_sprockets
      moj_assets = File.join(gem_path, 'assets')
      bower_components = File.join(gem_path, 'bower_components')
      govuk_assets = File.join(bower_components, 'govuk-template')

      Sprockets.append_path moj_assets
      Sprockets.append_path bower_components

      begin
        import_paths = JSON.parse(IO.read("#{govuk_assets}/bower.json"))['importPaths']
        import_paths.each do |path|
          Sprockets.append_path File.join(gem_path, 'bower_components', path)
        end
      rescue
      end

      # env.append_path moj_assets
      # Dir.chdir(moj_assets) do
      #   Dir['**/*.{js,png,jpg}'].each do |asset|
      #     # Rewrite sprockets logical paths to use assets dir defined in config
      #     root_dir = asset.split(File::SEPARATOR).shift
      #     Sprockets.import_asset(asset) do |logical_path|
      #       case logical_path.extname
      #       when '.js'
      #         logical_path.sub(root_dir, app.config.js_dir)
      #       else
      #         logical_path.sub(root_dir, app.config.images_dir)
      #       end
      #     end
      #   end
      # end
      # env.append_path govuk_assets
      # Dir.chdir(govuk_assets) do
      #   Dir['**/*.{js,png,jpg,ico}'].each do |asset|
      #     # Rewrite sprockets logical paths to use assets dir defined in config
      #     env.import_asset(asset) do |logical_path|
      #       root_dir = asset.split(File::SEPARATOR).shift
      #       case logical_path.extname
      #       when '.js'
      #         logical_path.sub(root_dir, app.config.js_dir)
      #       else
      #         logical_path.sub(root_dir, app.config.images_dir)
      #       end
      #     end
      #   end
      # end
    end
  end
end

Mojular.load!
