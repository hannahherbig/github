require 'github'

module GitHub
  class Comment
    def created_at
      self[:created_at].to_time
    end

    def updated_at
      self[:updated_at].to_time
    end

    def user
      @user ||= User.new(self[:user])
    end
  end
end
