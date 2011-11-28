$LOAD_PATH.unshift File.expand_path('../',    File.dirname(__FILE__))
$LOAD_PATH.unshift File.expand_path('../lib', File.dirname(__FILE__))

require 'rubygems'
require 'riot'

require 'github'

GitHub.debug = true
