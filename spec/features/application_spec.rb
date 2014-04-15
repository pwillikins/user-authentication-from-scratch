require 'spec_helper'
require 'capybara/rspec'

Capybara.app = Application

feature 'Homepage' do
  scenario 'user can register' do
    visit '/'
    click_link 'Register'
    fill_in 'email', with: 'joe@example.com'
    fill_in 'user_password', with: 'password'
    click_on 'Register'
    expect(page).to have_content 'Welcome, joe@example.com'
    click_link 'Logout'
    expect(page).to have_content 'You are not logged in.'
    expect(page).to have_link 'Login'
    expect(page).to have_link 'Register'
  end

  scenario 'returning user cannot login' do
    visit '/'
    click_link 'Login'
    fill_in 'email', with: 'joe@example.com'
    fill_in 'user_password', with: 'cat'
    click_on 'Login'
    expect(page).to have_content 'You are not logged in.'
  end
end