class UserController < ApplicationController

  get '/login' do
    if logged_in?
      redirect '/books'
    else
      erb :'/users/login'
    end
  end

  get '/signup' do
    if logged_in?
      redirect '/books'
    else
      erb :'/users/signup'
    end
  end

  get '/signup-failure' do
    erb :'/users/signup-failure'
  end

  get '/users/:slug' do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      erb :'/users/show'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/'
    else
      redirect '/login'
    end
  end

  post '/login' do
    user = User.find_by(name: params[:name])
    if user.name != "" && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/books'
    else
      redirect '/login'
    end
  end

  post '/signup' do
    user = User.new(params[:user])
    User.all.each do |u|
      if u.name == user.name
        redirect '/signup-failure'
      end
    end
      
    if user.save
      session[:user_id] = user.id
      redirect '/books'
    else
      redirect '/signup'
    end
  end

end