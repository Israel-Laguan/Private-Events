require 'rails_helper'

describe "GET '/sessions/new'", :type => :feature do
    it 'Shows the sign in form' do
      visit('http://localhost:3000/sessions/new')
      expect(page).to have_content("Email")
      expect(page).to have_content("Password")
      puts 'You can enter credentials here'
    end
  end

describe "the signin process", type: :feature do
    before :each  do
        User.create(name: 'Israel Laguan', email: 'israel@email.com', password: 'password', password_confirmation: 'password')
      end

    it "Sign in when correct credentials" do
      visit '/sessions/new'
      find('#signin-email').fill_in('sessions_email', with: 'israel@email.com')

      within("#signin-password") do
        fill_in 'sessions_password', with: 'password'
      end
      sleep(5)
      click_button 'Sign in'
      sleep(5)
      expect(page).to have_content 'Logged in'
    end
  end