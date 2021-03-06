require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/book.rb' )
require_relative( '../models/author.rb' )
require_relative( '../models/genre.rb' )
require_relative( '../models/source_language.rb' )



get '/welcome' do
  @books = Book.all
  erb(:low_stock)
end

get '/books' do #displays all books
  @books = Book.all
  erb(:"books/index")
end

get '/books/new' do #displays a new book form with dropdown menu of authors
  @authors = Author.all
  @genres = Genre.all
  @source_languages = SourceLanguage.all
  erb(:"books/new")
end

post '/books' do #creates new book
  @book = Book.new(params)
  @book.save
  erb(:"books/create")
end

get '/books/:id' do #displays an individual book
  @book = Book.find(params[:id])
  @books = Book.all

  index = @books.find_index {|book| book.id == params[:id].to_i()}

  if index != @books.length - 1
    @idplusone = @books[(index + 1)].id
  else
    @idplusone = @books[0].id
  end

  if index != 0
     @idminusone = @books[(index - 1)].id
  else
     @idminusone = @books[@books.length-1].id
  end

  erb(:"books/show")
end

get '/books/:id/edit' do #displays a form with pre-populated book info
  @authors = Author.all
  @genres = Genre.all
  @source_languages = SourceLanguage.all
  @book = Book.find(params[:id])
  erb(:"books/edit")
end

post '/books/:id' do #updates the book
  Book.new(params).update
  redirect to '/books'
end

post '/books/:id/delete' do #deletes the book
  book = Book.find(params[:id])
  book.delete()
  redirect to '/books'
end
