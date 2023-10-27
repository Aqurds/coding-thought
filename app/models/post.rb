class Post < ApplicationRecord
  has_many :comments, foreign_key: 'post_id'
  has_many :likes, foreign_key: 'post_id'

  belongs_to :user, foreign_key: 'author_id'

  def self.count_posts(user)
    user.update(postCounter: user.posts.size)
  end

  def recent_5_comments
    comments.order(created_at: :desc).limit(5)
  end
end
