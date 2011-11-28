require 'github'

module GitHub
  # represents a GitHub milestone
  class Milestone < Base
    def due_on
      self[:closed_at] && self[:closed_at].to_time
    end

    def created_at
      self[:created_at].to_time
    end

    def creator
      @creator ||= GitHub::User.new(self[:creator])
    end
  end
end
