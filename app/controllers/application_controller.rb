require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    use Rack::Flash
    set :session_secret, "supersecretpassword"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    #binding.pry      # Easy pry to access models
    erb :index
  end

  helpers do      #helpers block gives access in view
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def redirect_if_not_logged_in
      redirect '/login' if !logged_in?
    end
  end

end