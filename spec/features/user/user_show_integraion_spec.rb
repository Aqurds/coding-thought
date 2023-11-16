require 'rails_helper'
RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium, using: :chrome, options: {
      binary: '/usr/bin/google-chrome' # Replace with the actual Chrome binary location on your Chromebook
    }
  end
end
RSpec.describe 'User', type: :system do
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
    Post.create(author: user1, title: 'Share you code to the community', text: 'Code Sharing.', comments_counter: 0,
                likes_counter: 0)
    @post2 = Post.create(author: user1, title: 'Winter is going', text: 'Get wood to make fire.', comments_counter: 0,
                         likes_counter: 0)
    Post.create(author: user1, title: 'Peace in Earth', text: 'Keep peace in Earth.', comments_counter: 0,
                likes_counter: 0)
    Post.create(author: user1, title: 'Ocean is peace', text: 'Save the water.', comments_counter: 0,
                likes_counter: 0)
  end
  context 'show' do
    scenario 'profile should display the correct images' do
      visit users_path(user1)
      expect(page).to have_css('img[src="https://media.giphy.com/media/tZaFa1m8UfzXy/giphy.gif"]')
    end
    scenario 'should display the correct name' do
      visit users_path(user1)
      expect(page).to have_content('Nik')
    end
    scenario 'should display the correct post count' do
      visit users_path(user1)
      expect(page).to have_content('Number of posts:')
    end
    scenario 'should display the correct bio' do
      visit user_path(user1)
      expect(page).to have_content('This is Nik\'s bio')
    end

    scenario 'should display users first three posts' do
      visit user_path(user1)
      expect(page).to have_content('Ocean is peace')
      expect(page).to have_content('Peace in Earth')
      expect(page).to have_content('Winter is going')
    end
  end
  context 'show...' do
    scenario 'should display correct post titles and text' do
      visit user_path(user1)
      expect(page).to have_content('Ocean is peace')
      expect(page).to have_content('Save the water')
      expect(page).to have_content('Peace in Earth')
      expect(page).to have_content('Keep peace in Earth')
      expect(page).to have_content('Winter is going')
      expect(page).to have_content('Get wood to make fire')
    end
    scenario 'should display the correct button' do
      visit user_path(user1)
      expect(page).to have_link('See all posts')
    end
    scenario 'on link click it should redirect to the right post' do
      visit user_path(user1)
      click_link 'Post: Winter is going'
      expect(page).to have_current_path(user_post_path(user1, @post2))
    end
    scenario 'on link click it should redirect to users posts' do
      visit user_path(user1)
      click_link 'See all posts'
      expect(page).to have_current_path(user_posts_path(user1))
    end
  end
end
