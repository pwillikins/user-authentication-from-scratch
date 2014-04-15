require 'spec_helper'
require 'capybara/rspec'

Capybara.app = Application

feature 'Homepage' do
  scenario 'Shows the welcome message' do
    visit '/'
    click_link 'Register'
    fill_in 'email', with: 'joe@example.com'
    fill_in 'user_password', with: 'password'
    click_on 'Register'
    expect(page).to have_content 'Hello, joe@example.com'
    click_on 'Logout'
    expect(page).to have_content 'You are not logged in.'
    expect(page).to have_link 'Login'
    expect(page).to have_link 'Register'
  end
end