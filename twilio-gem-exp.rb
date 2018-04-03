require 'rubygems'
require 'twilio-ruby'

account_sid = "REDACTED"
auth_token = "REDACTED"

#set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new(account_sid, auth_token)

# Send a text to Lesley's mobile device
message = @client.messages.create(
  :from => "+17576006781", #Generic Twilio account number
  :to => "+REDACTED", #My actual phone number
  :body => "Huzzah!"
)

puts message.sid
