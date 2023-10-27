class Comment < ApplicationRecord
  belongs_to :post, foreign_key: 'post_id'
  belongs_to :user, foreign_key: 'user_id'

  def self.count_comments(post)
    post.update(commentsCounter: post.comments.size)
  end
end
