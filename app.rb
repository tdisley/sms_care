require 'sinatra'
require 'json'

get '/' do
  puts "#{params}"
  "Hello world"
end

post '/' do
  content_type :json
  {
    "payload" =>
    {
      "success" => true,
      "error" => nil
    }
  }.to_json
end

post '/callback' do
  "Hello World!"
end
