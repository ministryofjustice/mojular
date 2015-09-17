require 'bundler'
Bundler::GemHelper.install_tasks

task :prepare do
  # `bower cache clean && bower install`
  `bower install`
end

task default: :prepare
