require 'spec_helper'
require 'capybara/rspec'

Capybara.app = Application

feature 'Homepage' do
  scenario 'Shows the welcome message' do
    visit '/'
    click_link 'Register'
    fill_in 'email', with: 'joe@example.com'
    fill_in 'password', with: 'password'
    click_on  'Register'
    expect(page).to have_content 'Welcome, joe@example.com'
  end
end