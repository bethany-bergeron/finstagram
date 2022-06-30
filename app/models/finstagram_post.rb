class FinstagramPost < ActiveRecord::Base

    belongs_to :user
    has_many :comments
    has_many :likes
# ensures that a post record cant be created if theres no user associated with it
    validates_presence_of :user
    validates :photo_url, :user, presence: true

# defining this method just for finstagram posts only by putting it here instead of actions.rb
    def humanized_time_ago
        time_ago_in_seconds = Time.now - self.created_at
        time_ago_in_minutes = time_ago_in_seconds / 60
    
        if time_ago_in_minutes >= 60
          "#{(time_ago_in_minutes / 60).to_i} hours ago"
        else
          "#{time_ago_in_minutes.to_i} minutes ago"
        end
    end    

# we want the number of likes and 
# the number of comments on a finstagram post to be easily accessable
    def like_count
        self.likes.size
    end

    def comment_count
        self.comments.size
    end

end