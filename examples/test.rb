$LOAD_PATH.unshift File.expand_path('..',    File.dirname(__FILE__))
$LOAD_PATH.unshift File.expand_path('../lib', File.dirname(__FILE__))

require 'rubygems'
require 'github'

GitHub.debug = true

u = GitHub.user('andrew12')
u.name
u.hireable?
u.followers
u.followers.first
u.followers.first.name
u
