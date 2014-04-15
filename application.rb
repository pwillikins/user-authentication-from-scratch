require 'sinatra/base'
require 'bcrypt'

class Application < Sinatra::Application

  enable :sessions

  def initialize(app=nil)
    super(app)

    # initialize any other instance variables for you
    # application below this comment. One example would be repositories
    # to store things in a database.

  end

  get '/' do
    user_id = session[:id]
    user = DB[:users].where(id: user_id).first
    erb :index, locals: {user: user}
  end

  get '/register' do
    erb :register
  end

  post '/' do
    hashed_password = BCrypt::Password.create(
      params[:user_password]
    )
    user_id = DB[:users].insert(
      email: params[:email], password: hashed_password
    )

    session[:id] = user_id

    redirect '/'
  end
end