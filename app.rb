require 'sinatra'

get '/' do
  puts "#{params}"
  "Hello world"
end

post '/' do
  puts "#{params}"
  "Hello world"
end

post '/callback' do
  "Hello World!"
end
