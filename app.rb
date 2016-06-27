require 'sinatra'

get '/' do
  prinln params
  "Hello world"
end

post '/' do
  prinln params
  "Hello world"
end

post '/callback' do
  "Hello World!"
end
