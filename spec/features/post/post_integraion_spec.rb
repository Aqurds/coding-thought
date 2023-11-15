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
  context 'index' do
    scenario 'should display the correct images' do
      visit user_posts_path(user1)
      expect(page).to have_css('img[src="https://media.giphy.com/media/tZaFa1m8UfzXy/giphy.gif"]')
    end
    scenario 'should display the correct name and post count' do
      visit user_posts_path(user1)
      expect(page).to have_content('Nik')
      expect(page).to have_content('Number of posts:')
    end
    scenario 'should show post titles' do
      visit user_posts_path(user1)
      expect(page).to have_content('Post: Coding Thought Javascript')
      expect(page).to have_content('Post: Summar is going away')
      expect(page).to have_content('Post: Time to see the Ocean')
    end
    scenario 'should have part of post text' do
      visit user_posts_path(user1)
      expect(page).to have_content('Go and visit Ocean. Pass time, get peace.')
      expect(page).to have_content('....')
    end
    scenario 'should show first few comments' do
      visit user_posts_path(user1)
      click_link '2'
      expect(page).to have_content('Comments')
      expect(page).to have_content('Great commnet one')
      expect(page).to have_content('Great comment two')
      expect(page).to have_content('Great comment three')
      expect(page).to have_content('Great comment four')
    end
  end
  context 'index...' do
    scenario 'should show the number of comments for post' do
      visit user_posts_path(user1)
      click_link '2'
      expect(page).to have_content('Comments:')
    end
    scenario 'should show the number of like for a post' do
      visit user_posts_path(user1)
      click_link '2'
      expect(page).to have_content('Likes:')
    end
    scenario 'should redirect to the right post' do
      visit user_posts_path(user1)
      click_link '2'
      click_link 'Post: Winter is coming'
      expect(page).to have_current_path(user_post_path(user1, @post2))
    end
    scenario 'pagination links should work' do
      visit user_posts_path(user1)
      click_link '2'
      expect(page).to have_content('Post: Winter is coming')
      click_link '1'
      expect(page).to have_content('Post: Coding Thought Javascript')
      click_link '»'
      expect(page).to have_content('Post: Winter is coming')
      click_link '«'
      expect(page).to have_content('Post: Coding Thought Javascript')
    end
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
