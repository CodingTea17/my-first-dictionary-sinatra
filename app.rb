
require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/word')

get('/') do
  erb(:index)
end

post('/new_word') do
  word = Word.new(params["new_word"])
  if word.save()
    @last_word = Word.time_sift.the_word
    @current_dictionary = Word.sort
    @duplicate = false
    erb(:dictionary)
    # Super awesome redirect that will reroute the user to a GET route after the new word is saved to the dictionary.   Prevents error when reloading the page after making the POST.
    # redirect '/dictionary'
  else
    @current_dictionary = Word.sort
    @duplicate = word.the_word
    erb(:dictionary)
  end
end

get('/dictionary') do
  @current_dictionary = Word.sort
  @duplicate = "loader"
  erb(:dictionary)
end

get('/:id') do
  @definitions = Word.find(params[:id]).definition
  @define = Word.find(params[:id])
  @empty = "loader"
  erb(:definition)
end

post('/:id') do
  @definitions = Word.find(params[:id]).definition
  @define = Word.find(params[:id])
  if params["new_definition"] != ""
    Word.find(params[:id]).add_definition(params["new_definition"])
    @empty = false
    erb(:definition)
    # redirect '/'+params[:id]
  else
    @empty = true
    erb(:definition)
  end
end
