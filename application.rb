require 'sinatra/base'

class Application < Sinatra::Application

  def initialize(app=nil)
    super(app)

    # initialize any other instance variables for you
    # application below this comment. One example would be repositories
    # to store things in a database.

  end

  get '/' do
    users_table = DB[:users]
    erb :index, locals: {user_list: users_table.to_a}
  end

  get '/register' do
    erb :register
  end

  post '/' do
    users_table = DB[:users]
    users_table.insert(email: params[:email], password: params[:password])
    redirect '/'
  end
end