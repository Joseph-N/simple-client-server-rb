require 'socket'
require File.expand_path("lib/dictionary")
require File.expand_path("lib/drugs")

class Server

  def initialize(ip, port)
    @server = TCPServer.new(ip, port)
    @address = ip
    @port = port

    begin
      @dictionary = Dictionary.new
      @drugs = Drugs.new

      bootup_messages
    rescue Exception => e
      abort "Database files not found.\nError:  #{e.message}\n"
    end
  end


  def bootup_messages
    puts "=> Booting server"
    puts "=> Server successfully listening on #{@address}:#{@port}"
    puts "=> CTRL-C to shutdown server"
    puts "[#{Time.now.strftime('%Y-%m-%d %I:%M:%S')}] INFO WXserver 1.2"
  end


  def run
    loop {
      Thread.start(@server.accept) do |client|
        puts ""
        puts "Client connected: [#{client.peeraddr.join(':')}]"
        client.puts "Welcome to smart server"
        listen_client_messages(client)
      end
    }
  end


  def listen_client_messages(client)
    loop {
      msg = client.gets.chomp
      puts ""
      puts "msg from [#{client.peeraddr.join(':')}]: #{msg}"

      if msg.slice(0..3).eql?("dic-")
        puts "   --> Dictionary check detected. Looking up...........#{msg[4..-1]}"

        results = @dictionary.find(msg[4..-1])
        client.puts "dic-[#{results[:code]}]: #{results[:message]}"
      elsif msg.slice(0..3).eql?("drg-")
        puts "   --> Drugs lookup detected. Looking up.............#{msg[4..-1]}"
        results = @drugs.find(msg[4..-1])
        client.puts "drg-[#{results[:code]}]: #{results[:message]}"
      else
        client.puts "[500 Internal Server Error]: Unkown request"
      end
    }
  end
end


server = Server.new("0.0.0.0", 3000)
server.run
