# spec/models/like_spec.rb

require 'rails_helper'

RSpec.describe Like, type: :model do
  # Validation tests
  it { should belong_to(:user).with_foreign_key('user_id') }
  it { should belong_to(:post).with_foreign_key('post_id') }

  # Method tests
  describe '.count_likes' do
    it 'updates the likesCounter for the associated post' do
      post = create(:post)
      3.times { create(:like, post: post) }

      expect { Like.count_likes(post) }.to change { post.reload.likesCounter }.from(nil).to(3)
    end
  end
end
