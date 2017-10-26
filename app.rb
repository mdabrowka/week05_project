require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/authors_controller')
require_relative('controllers/source_language_controller')
require_relative('controllers/genres_controller')
require_relative('controllers/books_controller')

get '/' do
  erb(:low_stock)
end
