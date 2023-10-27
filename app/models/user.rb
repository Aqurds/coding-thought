class User < ApplicationRecord
  has_one_attached :photo

  has_many :comments, foreign_key: 'user_id'
  has_many :likes, foreign_key: 'user_id'
  has_many :posts, foreign_key: 'author_id'

  def self.recent_3_posts(user)
    user.posts.order(created_at: :desc).limit(3)
  end
end
