require 'rails_helper'
RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium, using: :chrome, options: {
      binary: '/usr/bin/google-chrome' # Replace with the actual Chrome binary location on your Chromebook
    }
  end
end
RSpec.describe 'Post', type: :system do
  before do
    driven_by(:rack_test)
  end
  let(:user1) do
    User.create(name: 'Nik', photo: 'https://media.giphy.com/media/tZaFa1m8UfzXy/giphy.gif',
                bio: 'This is Nik\'s bio', posts_counter: 0)
  end
  before do
    @user2 = User.create(name: 'Ammy', photo: 'https://media.giphy.com/media/K4x1ZL36xWCf6/giphy.gif',
                         bio: 'This is Ammy\'s bio', posts_counter: 0)
    Post.create(author: user1, title: 'Coding Thought Javascript', text: 'Think before you code.', comments_counter: 0,
                likes_counter: 0)
    @post2 = Post.create(author: user1, title: 'Winter is coming', text: 'Get wood to make fire.', comments_counter: 0,
                         likes_counter: 0)
    Post.create(author: user1, title: 'Summar is going away', text: 'Will miss the shine.', comments_counter: 0,
                likes_counter: 0)
    Post.create(author: user1, title: 'Time to see the Ocean',
                text: 'Go and visit Ocean. Pass time, get peace.', comments_counter: 0, likes_counter: 0)
    @cmt1 = Comment.create(user: @user2, post: @post2, text: 'Great commnet one')
    @cmt2 = Comment.create(user: @user2, post: @post2, text: 'Great comment two')
    @cmt3 = Comment.create(user: user1, post: @post2, text: 'Great comment three')
    @cmt4 = Comment.create(user: @user2, post: @post2, text: 'Great comment four')
    @like1 = Like.create(user: @user2, post: @post2)
    @like1 = Like.create(user: user1, post: @post2)
  end
  context 'show' do
    scenario 'should display the correct post title and author' do
      visit user_post_path(user1, @post2)
      expect(page).to have_content('Winter is coming by Nik')
    end
    scenario 'should show the number of comments for post' do
      visit user_post_path(user1, @post2)
      expect(page).to have_content('Comments:')
    end
    scenario 'should show the number of like for a post' do
      visit user_post_path(user1, @post2)
      expect(page).to have_content('Likes:')
    end
    scenario 'should show the post body' do
      visit user_post_path(user1, @post2)
      expect(page).to have_content('Get wood to make fire.')
    end
    scenario 'should show the right comment and commentor for a comment' do
      visit user_post_path(user1, @post2)
      expect(page).to have_content('Ammy: Great commnet one')
      expect(page).to have_content('Nik: Great comment three')
    end
  end
end
