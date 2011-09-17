require 'hashie'

require 'github/helpers'

module GitHub
  # @param [String] login
  # @return [User] a User object representing the `login` user
  def user(login)
    User.new(login)
  end

  # represents a GitHub user
  class User < Hashie::Dash
    include GitHub::Helpers

    property :login
    property :id
    property :name
    property :company
    property :blog
    property :location
    property :email
    property :hireable
    property :bio
    property :created_at
    property :url
    property :api_url

    alias :hireable? :hireable

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
        load_hash(attributes)
      end

      @loaded = false
    end

    # Loads the entire user object from the API
    def load!
      @loaded = true

      attributes = get_json("#{API}/users/#{login}")
      load_hash(attributes)
    end

    # @return [Array<User>] users following this user
    def followers
      @followers ||= get_json("#{API}/users/#{login}/followers").
                     collect { |hash| User.new(hash) }
    end

    # @return [Array<User>] users this user is following
    def following
      json = get_json("#{API}/users/#{login}/following")
      json.collect { |hash| User.new(hash) }
    end

    def [](prop)
      load! unless keys.include?(prop) || @loaded

      super(prop)
    end

    private

    def load_hash(hash)
      mash = hash.to_mash
      # rename these
      mash.api_url = mash.url if mash.url
      mash.delete(:url)
      mash.url = mash.html_url if mash.html_url
      # delete any that aren't defined
      mash.delete_if { |k, v| not self.class.property? k }

      update(mash.to_hash)
    end
  end
end
