require 'github'

module GitHub
  # Any GitHub object that has a url attribute that will return the entire
  # object will subclass this.
  class Base < Hashie::Mash
    include GitHub::Helpers

    # @param [Hash] source_hash
    # @param [Boolean] loaded is this object already loaded?
    def initialize(source_hash = {}, loaded = nil)
      if loaded == true
        @loaded = true
        @exists = true
      else
        @loaded = false
        @exists = nil
      end

      super(source_hash)
    end

    # Duplicates the current object as a new object
    def dup
      self.class.new(self, @loaded)
    end

    # Loads the entire object from the API
    def load!
      update(get_json(url))
    rescue
      @exists = false
    else
      @exists = true
    ensure
      @loaded = true
    end

    def [](key)
      load! unless keys.include?(convert_key(key)) or @loaded

      super
    end

    def respond_to?(name, *rest)
      load! unless keys.include?(convert_key(name)) or @loaded

      super
    end

    def exists?
      load! unless @loaded

      @exists
    rescue
      nil
    end
  end
end
