require 'sinatra'

get '/' do
  "Hello World!"
  prinln params
end

post '/callback' do
  "Hello World!"
end
