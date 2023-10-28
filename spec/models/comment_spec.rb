# spec/models/comment_spec.rb

require 'rails_helper'

RSpec.describe Comment, type: :model do
  # Validation tests
  it { should belong_to(:user).with_foreign_key('user_id') }
  it { should belong_to(:post).with_foreign_key('post_id') }

  # Method tests
  describe '.count_comments' do
    it 'updates the commentsCounter for the associated post' do
      post = create(:post)
      5.times { create(:comment, post: post) }

      expect { Comment.count_comments(post) }.to change { post.reload.commentsCounter }.from(nil).to(5)
    end
  end
end
