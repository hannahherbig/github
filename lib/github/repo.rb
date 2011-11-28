require 'github'

module GitHub
  # @param [String] login
  # @return [User] a User object representing the `login` user
  def repository(user, repo)
    Repository.new(get_json("#{API}/repos/#{user}/#{repo}"), true)
  end

  alias :repo :repository

  class Repository < Base
    def created_at
      self[:created_at].to_time
    end

    # @return [Time] when this repo was pushed
    def pushed_at
      self[:pushed_at].to_time
    end

    # @return [User, Organization] the owner of this repo
    def owner
      @owner ||=
        if organization
          GitHub::Organization.new(self[:owner])
        else
          GitHub::User.new(self[:owner])
        end
    end

    # @return [Organization] this repo's organization or false
    def organization
      if @organization.nil?
        @organization = if self[:organization]
          GitHub::Organization.new(self[:organization])
        else
          false
        end
      end

      @organization
    end

    # @return [Array<User>] the collaborators of this project
    def collaborators
      @collaborators ||= get_json("#{url}/collaborators").collect do |hash|
        GitHub::User.new(hash)
      end
    end

    # @return [Array<Repository>] forks of this repository
    def forks
      @forks ||= get_json("#{url}/forks").collect do |hash|
        GitHub::Repository.new(hash)
      end
    end

    # @return [Array<User>] users watching this repository
    def watchers
      @watchers ||= get_json("#{url}/watchers").collect do |hash|
        GitHub::User.new(hash)
      end
    end
  end
end
