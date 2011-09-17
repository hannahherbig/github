require 'rubygems'
require 'rake'
require 'rake/testtask'

$LOAD_PATH.unshift File.expand_path('.',   File.dirname(__FILE__))
$LOAD_PATH.unshift File.expand_path('lib', File.dirname(__FILE__))

require 'github'

task :default => [:test]

begin
  require 'yard'
  YARD::Rake::YardocTask.new do |t|
    t.files = ['lib/**/*.rb']
  end
rescue LoadError
end

Rake::TestTask.new do |t|
    t.libs << 'test'
    t.pattern = 'test/**/*_test.rb'
    t.verbose = false
end
