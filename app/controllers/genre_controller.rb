class GenreController < ApplicationController

  get '/genres' do
    redirect_if_not_logged_in
    
    @genres = Genre.all
    erb :'/genres/index'
  end

  get '/genres/:slug' do
    redirect_if_not_logged_in

    @genre = Genre.find_by_slug(params[:slug])
    erb :'/genres/show'
  end

end