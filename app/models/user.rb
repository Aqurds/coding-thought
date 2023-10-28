class User < ApplicationRecord
  has_one_attached :photo

  validates :name, presence: true
  validates :postCounter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :comments, foreign_key: 'user_id'
  has_many :likes, foreign_key: 'user_id'
  has_many :posts, foreign_key: 'author_id'

  def self.recent_3_posts(user)
    user.posts.order(created_at: :desc).limit(3)
  end
end
