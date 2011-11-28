require 'github'

module GitHub
  class Repository
    # @return [Array<Issue>] the issues for this repo
    def issues
      @issues ||= get_json("#{url}/issues").collect do |hash|
        GitHub::Issue.new(hash)
      end
    end

    # @param id issue id
    # @return [Issue] this issue
    def issue(id)
      GitHub::Issue.new(get_json("#{url}/issues/#{id}"), true)
    end
  end

  # represents a GitHub issue
  class Issue < Base
    def closed_at
      self[:closed_at] && self[:closed_at].to_time
    end

    def created_at
      self[:created_at].to_time
    end

    def updated_at
      self[:updated_at].to_time
    end

    def user
      @user ||= GitHub::User.new(self[:user])
    end

    def assignee
      if self[:assignee]
        @assignee ||= GitHub::User.new(self[:assignee])
      end
    end

    def milestone
      @milestone = GitHub::Milestone.new(self[:milestone])
    end

    def comments
      @comments ||= get_json("#{url}/comments").collect do |hash|
        GitHub::Comment.new(hash)
      end
    end
  end
end
