Dir["*/**.rb"].each { |fn| require fn[0...-3] } # XXX

module GitHub
  include GitHub::Helpers

  API = "https://api.github.com"

  attr_accessor :debug

  extend self
end
