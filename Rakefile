require 'bundler'
Bundler::GemHelper.install_tasks

task :prepare do
  `bower cache clean && bower install`
end

task default: :prepare
