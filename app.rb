
require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/word')

get('/') do
  erb(:index)
end

post('/new_word') do
  word = Word.new(params["new_word"])
  word.save()
  # Super awesome redirect that will reroute the user to a GET route after the new word is saved to the dictionary. Prevents error when reloading the page after making the POST.
  redirect '/dictionary'
end

get('/dictionary') do
  @current_dictionary = Word.sort
  erb(:dictionary)
end

get('/:id') do

end
