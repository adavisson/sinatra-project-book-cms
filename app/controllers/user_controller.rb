class UserController < ApplicationController

  get '/login' do
    erb :'/users/login'
  end

  get '/signup' do
    erb :'/users/signup'
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/'
    else
      redirect '/login'
    end
  end

  post '/signup' do
    user = User.new(params[:user])
    if user.save
      session[:user_id] = user.id
      redirect '/books'
    else
      redirect '/signup'
    end
  end

end