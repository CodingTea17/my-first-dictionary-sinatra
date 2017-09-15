
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
    # Super awesome redirect that will reroute the user to a GET route after the new word is saved to the dictionary.   Prevents error when reloading the page after making the POST.
    redirect '/dictionary'
  else
    @current_dictionary = Word.sort
    @duplicate = word.the_word
    erb(:dictionary)
  end
end

get('/dictionary') do
  @current_dictionary = Word.sort
  @last_word = Word.time_sift.the_word
  @duplicate = false
  erb(:dictionary)
end

get('/:id') do
  @definitions = Word.find(params[:id]).definition
  @define = Word.find(params[:id])
  @empty = false
  erb(:definition)
end

post('/:id') do
  if params["new_definition"] != ""
    Word.find(params[:id]).add_definition(params["new_definition"])
    redirect '/'+params[:id]
  else
    @definitions = Word.find(params[:id]).definition
    @define = Word.find(params[:id])
    @empty = true
    erb(:definition)
  end
end
