class GenreController < ApplicationController

  get '/genres' do
    if logged_in?
      @genres = Genre.all
      erb :'/genres/index'
    else
      redirect '/login'
    end
  end

  get '/genres/:slug' do
    if logged_in?
      @genre = Genre.find_by_slug(params[:slug])
      erb :'/genres/show'
    else
      redirect '/login'
    end
  end



end