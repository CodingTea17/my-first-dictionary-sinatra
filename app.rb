
require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/word')

get('/') do
  erb(:index)
end

post('/new_word') do
  word = Word.new(params["new_word"])
  status = word.save()
  @current_dictionary = Word.sort
  if status == "saved"
    @last_word = Word.time_sift.the_word
    @current_dictionary = Word.sort
    @error = status
    erb(:dictionary)
  elsif status == "duplicate"
    @error = word.the_word
    erb(:dictionary)
  elsif status == "NAW"
    @error = status
    erb(:dictionary)
  end
end

get('/list') do
  @current_dictionary = Word.sort
  erb(:list)
end

# Originally this was the default route that the POST was redirected to. Now it is used witht the back button.
get('/dictionary') do
  @current_dictionary = Word.sort
  @error = "loader"
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
  else
    @empty = true
    erb(:definition)
  end
end
