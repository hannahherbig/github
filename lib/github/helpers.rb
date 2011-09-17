require 'hashie'
require 'json'
require 'open-uri'

class Hash
  # @return A new Mash with the contents of this Hash
  def to_mash
    Hashie::Mash.new(self)
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
      JSON.parse(get(url))
    end
  end
end

module Hashie
  module PrettyInspect
    # The default looks like #<Object ...>, Hashie makes this look like
    # <#Hashie::Mash ...>. Let's fix that.
    def hashie_inspect
      ret = "#<#{self.class.to_s}"
      stringify_keys.keys.sort.each do |key|
        ret << " #{key}=#{self[key].inspect}"
      end
      ret << ">"
      ret
    end
  end
end
