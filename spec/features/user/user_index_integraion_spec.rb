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
  context 'index' do
    scenario 'should display the correct images' do
      visit users_path
      expect(page).to have_css('img[src="https://media.giphy.com/media/tZaFa1m8UfzXy/giphy.gif"]')
      expect(page).to have_css('img[src="https://media.giphy.com/media/K4x1ZL36xWCf6/giphy.gif"]')
    end
    scenario 'should display the correct name and post count' do
      visit users_path
      expect(page).to have_content('Nik')
      expect(page).to have_content('Number of posts:')
    end
    scenario 'See user profile page when user name clicked' do
      visit user_path(user1)
      expect(page).to have_link('See all posts')
      click_link 'Nik'
      expect(page).to have_current_path(user_path(user1))
      visit user_path(@user2)
      click_link 'Ammy'
      expect(page).to have_current_path(user_path(@user2))
    end
  end
end
