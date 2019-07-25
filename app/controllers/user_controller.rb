class UserController < ApplicationController

  get '/login' do
    if logged_in?
      redirect '/books'
    else
      erb :'/users/login'
    end
  end

  get '/login-failure' do
    erb :'/users/login-failure'
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
    redirect_if_not_logged_in
    
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/logout' do
    redirect_if_not_logged_in

    session.clear
    redirect '/'
  end

  post '/login' do
    user = User.find_by(name: params[:name])
    redirect '/login-failure' if user == nil
    
    if user.name != "" && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/books'
    else
      redirect '/login'
    end
  end

  post '/signup' do
    #User.all.each do |u|
    #  if u.name == user.name
    #    redirect '/signup-failure'
    #  end
    #end

    if User.find_by(name: params[:user][:name])
      redirect '/signup-failure'
    end

    user = User.new(params[:user])
    
    if (user.name != "") && (user.email != "") && (user.password != "") && user.save
      session[:user_id] = user.id
      redirect '/books'
    else
      redirect '/signup-failure'
    end
  end

end