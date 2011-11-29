# XXX - don't do this kind of require
%w(helpers base user org repo comment).each { |m| require "github/#{m}" }

require 'hashie'

module GitHub
  include GitHub::Helpers

  API = "https://api.github.com"

  attr_accessor :debug

  extend self
end
