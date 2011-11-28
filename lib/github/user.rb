require 'github'

module GitHub
  # @param [String] login
  # @return [User] a User object representing the `login` user
  def user(login)
    User.new(get_json("#{API}/users/#{login}"), true)
  end

  # represents a GitHub user
  class User < Base
    # @return [Boolean] whether or not this user is hireable
    def hireable?
      hireable
    end

    # @return [Time] when this user was created
    def created_at
      self[:created_at].to_time
    end

    # @return [Array<User>] users following this user
    def followers
      @followers ||= get_json("#{url}/followers").collect do |hash|
        User.new(hash)
      end
    end

    # @return [Array<User>] users this user is following
    def following
      @following ||= get_json("#{url}/following").collect do |hash|
        User.new(hash)
      end
    end

    # @return [Array<Organization>] organizations this user is a member of
    def organizations
      @organizations ||= get_json("#{url}/orgs").collect do |hash|
        Organization.new(hash)
      end
    end

    # @return [Array<Repository>] repositories for this user
    def repositories
      @repositories ||= get_json("#{url}/repos").collect do |hash|
        Repository.new(hash)
      end
    end

    alias :orgs  :organizations
    alias :repos :repositories
  end
end
