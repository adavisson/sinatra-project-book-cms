class AuthorController < ApplicationController

  get '/authors' do
    redirect_if_not_logged_in

    @authors = Author.all
    erb :'/authors/index'
  end

  get '/authors/:slug' do
    redirect_if_not_logged_in

    @author = Author.find_by_slug(params[:slug])
    erb :'/authors/show'

  end

end