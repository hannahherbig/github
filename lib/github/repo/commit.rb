require 'github'

module GitHub
  class Repository
    # @return [Array<Commit>] the commits for this repo
    def commits
      @commits ||= get_json("#{url}/commits").collect do |hash|
        GitHub::Commit.new(hash)
      end
    end

    # @param [String] sha the sha hash of this commit
    # @return [Commit] this commit
    def commit(sha)
      GitHub::Commit.new(get_json("#{url}/commits/#{sha}"), true)
    end
  end

  # represents a GitHub commit
  class Commit < Base
    # @return [Data::Commit] the commit object for this commit
    def commit
      raise NotImplementedError
    end

    # @return [Data::Tree] the tree object for this commit
    def tree
      raise NotImplementedError
    end

    # @return [Array<Commit>] the parents of this commit
    def parents
      @parents ||= self[:parents].collect { |hash| GitHub::Commit.new(hash) }
    end

    # @return [User] the user who commited this commit
    def committer
      @committer ||= User.new(self[:committer])
    end

    def author
      @author ||= User.new(self[:author])
    end

    def comments
      @comments ||= get_json("#{url}/comments").collect do |hash|
        GitHub::Comment.new(hash)
      end
    end
  end
end
