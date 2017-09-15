
require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/word')

get('/') do
  erb(:index)
end

post('new_word') do
  
end

get('/definition/:word') do

end
