require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' #database configuration
require './models/message'
require 'json'

get '/' do
  puts "#{params}"
  erb :index
end

post '/' do
  message = Message.new(params)
  p message
  content_type :json
  if message.save
    {
      "payload" =>
      {
        "success" => true,
        "error" => nil,
        "task": "send",
        "messages": [
          {
            "to": "#{message.from}",
            "message": "Replying from intelligence",
            "uuid": "#{message.message_id}"
          }
        ]
      }
    }.to_json
  else
    {
      "payload" =>
      {
        "success" => false,
        "error" => "Cannot save the message",
        "task": "send",
        "messages": [
          {
            "to": "#{message.from}",
            "message": "Try  again",
            "uuid": "#{message.message_id}"
          }
        ]
      }
    }.to_json
  end
end

