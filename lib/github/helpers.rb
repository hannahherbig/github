require 'json'
require 'open-uri'
require 'time'

require 'hashie'

require 'github'

class Hash
  # @return [Hashie::Mash] a new Mash with the contents of this Hash
  def to_mash
    Hashie::Mash.new(self)
  end
end

class Array
  # @return [Array<Hashie::Mash>] the contents of this array converted to
  #   Mashes
  def to_mash
    collect { |inner| inner.to_mash }
  end
end

class String
  def to_time
    Time.parse(self)
  end
end

module GitHub
  module Helpers
    private

    def get(url)
      puts "loading #{url}" if GitHub.debug
      open(url).read
    end

    def get_json(url)
      JSON.parse(get(url)).to_mash
    end
  end
end
