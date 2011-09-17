$LOAD_PATH.unshift File.expand_path('..',    File.dirname(__FILE__))
$LOAD_PATH.unshift File.expand_path('../lib', File.dirname(__FILE__))

require 'rubygems'
require 'github'

GitHub.debug = true
u = GitHub.user('mytestuser')
u.name
u.followers
u.hireable?
u
