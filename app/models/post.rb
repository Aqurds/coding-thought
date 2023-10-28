class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  validates :commentsCounter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likesCounter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :comments, foreign_key: 'post_id'
  has_many :likes, foreign_key: 'post_id'

  belongs_to :author, class_name: 'User'

  def self.count_posts(user)
    user.update(postCounter: user.posts.size)
  end

  def recent_5_comments
    comments.order(created_at: :desc).limit(5)
  end
end
