require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' #database configuration
require './models/message'
require 'json'

get '/' do
  @messages = Message.order(id: :desc).all
  erb :index
end

post '/' do
  message = Message.new(params)
  content_type :json
  if message.save
    success_response(message).to_json
  else
    error_response(message).to_json
  end
end

private
def success_response(message)
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
  }
end

def error_response(message)
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
  }
end

