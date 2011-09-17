require 'hashie'

require 'github/helpers'

module GitHub
  # @param [String] login
  # @return [User] a User object representing the `login` user
  def user(login)
    User.new(login)
  end

  # represents a GitHub user
  class User < Hashie::Mash
    include GitHub::Helpers

    # @param [String] login
    # @param [Hash] attributes
    # @return [User] a new user object
    def initialize(*args)
      if args.size > 2
        raise ArgumentError,
          "wrong number of arguments (#{args.size} for (0..2))"
      end

      super()

      self.login = args.shift if args.first.is_a? String

      if args.first.is_a? Hash
        attributes = args.shift
        update(attributes)
      end

      @loaded = false
    end

    def hireable?
      hireable
    end

    # Loads the entire user object from the API
    def load!
      @loaded = true

      attributes = get_json("#{API}/users/#{login}")
      update(attributes)
    end

    # @return [Array<User>] users following this user
    def followers
      @followers ||= get_json("#{API}/users/#{login}/followers").
                     collect { |hash| User.new(hash) }
    end

    # @return [Array<User>] users this user is following
    def following
      @following ||= get_json("#{API}/users/#{login}/followers").
                     collect { |hash| User.new(hash) }
    end

    def [](key)
      load! unless keys.include?(key) || @loaded

      super(key)
    end
  end
end
