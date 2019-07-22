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
    if logged_in?
      @authors = Author.all
      @genres = Genre.all
      erb :'/books/new'
    else
      redirect '/login'
    end
  end

  get '/books/:slug' do
    if logged_in?
      @book = Book.find_book_by_slug(params[:slug])
      erb :'/books/show'
    else
      redirect '/login'
    end
  end

  get '/books/:slug/edit' do
    if logged_in?
      @authors = Author.all
      @genres = Genre.all
      @book = Book.find_book_by_slug(params[:slug])
      erb :'/books/edit'
    else
      redirect '/login'
    end
  end

  post '/books' do
    user = current_user
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
    user.books << book

    if !author.genres.include?(genre)
      author.genres << genre
    end

    redirect '/books'
  end

  patch '/books/:slug' do
    book = Book.find_book_by_slug(params[:slug])

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
      
    book.update(title: params[:book][:title], author_id: author.id, genre_id: genre.id)

    redirect '/books'
  end

  delete '/books/:slug' do
    if logged_in?
      book = Book.find_book_by_slug(params[:slug])
      if book.user == current_user
        book.delete
        redirect '/books'
      else
        #Create error
      end
    else
      redirect '/login'
    end
  end

end