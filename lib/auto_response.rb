require 'singleton'
require 'open-uri'

class AutoResponse
  include Singleton

  def initialize
    url = "http://sms-care.makingdevs.com.s3.amazonaws.com/messages.txt"
    message_text = open(url) { |io| io.read }
    @responses = {}
    message_text.split("\n").each do |line|
      split_message = line.split('|')
      @responses[split_message[0]] = split_message[1]
    end
  end

  def respond_to(message)
    code = message.scan(/\d{3}/).first
    message = @responses.find { |k,v| k == code }
    if message
      message[1]
    else
      "Please write us and include some code: 111 for contact, 222 for meet you better, 333 for mor info"
    end
  end

end
