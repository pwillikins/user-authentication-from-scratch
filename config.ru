ENV['DATABASE_URL'] ||= 'postgres://gschool_user:password@localhost/authentication_development'
require_relative './boot'
run Application