require 'github'

module GitHub
  # @param [String] org
  # @return [User] an Org object representing the `org` organization
  def organization(org)
    Organization.new(get_json("#{API}/orgs/#{org}"), true)
  end

  alias :org :organization

  # represents a GitHub organization
  class Organization < Base
    # @return [Time] when this org was created
    def created_at
      self[:created_at].to_time
    end

    # @return [Array<User>] members of this organization
    def members
      @members ||= get_json("#{url}/members").collect do |hash|
        User.new(hash)
      end
    end

    # @return [Array<Repository>] repositories for this user
    def repositories
      @repositories ||= get_json("#{url}/repos").collect do |hash|
        Repository.new(hash)
      end
    end

    alias :repos :repositories
  end
end
