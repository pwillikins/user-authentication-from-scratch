require 'spec_helper'
require 'capybara/rspec'

Capybara.app = Application

feature 'User Registration' do
  scenario 'user can register, logout and log back in' do
    visit '/'

    click_link 'Register'
    fill_in 'email', with: 'paul'
    fill_in 'user_password', with: 'paul'
    click_on 'Register'
    expect(page).to have_content 'Welcome, paul'

    click_link 'Logout'
    expect(page).to have_content 'You are not logged in.'
    expect(page).to have_link 'Login'
    expect(page).to have_link 'Register'

    click_link 'Login'
    fill_in 'email', :with => 'paul'
    fill_in 'user_password', :with => 'paul'
    click_on 'Login'
    expect(page).to have_content 'Welcome, paul'
    expect(page).to have_link 'Logout'
  end

  scenario 'user cannot login with invalid email' do
    visit '/'

    click_link 'Login'
    fill_in 'email', :with => 'name'
    fill_in 'user_password', :with => 'name'
    click_on 'Login'
    expect(page).to have_content 'Email / Password is invalid'
    end

  scenario 'user cannot login with a blank email' do
    visit '/'

    click_link 'Login'
    fill_in 'email', :with => ''
    fill_in 'user_password', :with => 'name'
    click_on 'Login'
    expect(page).to have_content 'Email cannot be blank'
    end

  scenario 'user cannot login with a invalid password' do
    visit '/'

    click_link 'Login'
    fill_in 'email', :with => 'paul'
    fill_in 'user_password', :with => 'cat'
    click_on 'Login'
    expect(page).to have_content 'Email / Password is invalid'
  end

  scenario 'only admin user can see the users page' do
    visit '/'
    click_link 'Login'
    DB[:users].insert(:email => 'cat@cat.com',
                      :password => BCrypt::Password.create('cat'),
                      :admin => true)

    fill_in 'email', :with => 'cat@cat.com'
    fill_in 'user_password', :with => 'cat'
    click_on 'Login'
    expect(page).to have_content 'Welcome, cat@cat.com'
    expect(page).to have_link 'View all users'
  end
end