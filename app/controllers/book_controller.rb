class BookController < ApplicationController

  get '/books' do
    if logged_in?
      @books = Book.all
      erb :'/books/index'
    else
      redirect '/login'
    end
  end

  get '/books/new' do
    @authors = Author.all
    @genres = Genre.all
    erb :'/books/new'
  end

  post '/books' do
    book = Book.create(params[:book])
    if params[:author][:name] != ""
      author = Author.create(params[:author])
    else
      author = Author.find(params[:book][:author_id])
    end
    
    if params[:genre][:name] != ""
      genre = Genre.create(params[:genre])
    else
      genre = Genre.find(params[:book][:genre_id])
    end

    author.books << book
    genre.books << book

    if !author.genres.include?(genre)
      author.genres << genre
    end

    redirect '/books'
  end

end