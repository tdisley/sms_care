require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require './environments'

class Post < ActiveRecord::Base
end

get '/' do
  puts "#{params}"
  "Hello world"
end

post '/' do
  secret = params['secret']
  from = params['from']
  message = params['message']
  sent_timestamp = params['sent_timestamp']
  sent_to = params['sent_to']
  message_id = params['message_id']
  device_id = params['device_id']
  puts "#{secret}|#{from}|#{message}|#{sent_timestamp}|#{sent_to}|#{message_id}|#{device_id}"
  content_type :json
  {
    "payload" =>
    {
      "success" => true,
      "error" => nil,
      "task": "send",
      "messages": [
        {
          "to": "#{from}",
          "message": "Replying from intelligence",
          "uuid": "#{message_id}"
        }
      ]
    }
  }.to_json
end

post '/callback' do
  "Hello World!"
end
