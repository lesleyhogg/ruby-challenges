require 'socket'

server  = 'rajaniemi.freenode.net'
port    = 6667
socket  = TCPSocket.open(server, port)

nickname  = 'SkillcrushBotOMG'
channel   = '#WhenHoggsCanFly'

socket.puts "NICK #{nickname}"
socket.puts "USER #{nickname} 0 * #{nickname}"
socket.puts "JOIN #{channel}"
socket.puts "PRIVMSG #{channel} :I am so happy to be here!"

while message = socket.gets do
  puts message

  if message.match('^PING :')
    server = message.split(':').last
    puts "PONG #{server}"
    socket.puts "PONG #{server}"
  elsif message.match('How are you?')
    puts "PRIVMSG #{channel} :I am great, thanks!"
    socket.puts "PRIVMSG #{channel} :I am great, thanks!"
  elsif message.match('inspire me')
    puts "PRIVMSG #{channel} :It is during our darkest moments that we must focus to see the light. – Aristotle"
    socket.puts "PRIVMSG #{channel} :It is during our darkest moments that we must focus to see the light. – Aristotle"
  end
end
