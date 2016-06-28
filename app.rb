require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' #database configuration
require './models/message'
require 'json'
require 'sinatra-websocket'

set :server, 'thin'
set :sockets, []

get '/' do
  if !request.websocket?
    @messages = Message.all
    erb :index
  else
    request.websocket do |ws|
      ws.onopen do
        ws.send("Hello World!")
        settings.sockets << ws
      end
      ws.onmessage do |msg|
        EM.next_tick { settings.sockets.each{|s| s.send(msg) } }
      end
      ws.onclose do
        warn("wetbsocket closed")
        settings.sockets.delete(ws)
      end
    end
  end
end

get '/sample' do
  msg = "Hello!!!!"
  EM.next_tick { settings.sockets.each{|s| s.send(msg) } }
  "sending"
end

post '/' do
  message = Message.new(params)
  content_type :json
  if message.save
    EM.next_tick { settings.sockets.each{|s| s.send(message) } }
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

