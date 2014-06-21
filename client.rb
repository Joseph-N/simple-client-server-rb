require 'socket'

class Client
  def initialize(server)
    @server = server
    @request = nil
    @response = nil

    puts @server.gets.chomp

    render_menu

    @request.join

  end

  def render_menu
    @request = Thread.new do
      menu = <<-EOF
Choose an option below
  a) Dictionary Lookup
  b) Drugs Lookup
  c) Exit

[INFO] Enter 'back' at any prompt to come back to this menu

EOF


      print "#{menu}Choice: "
      choice = gets.chomp

      case choice
        when "a"
          print "Enter word: "
          send_message(choice)
        when "b"
          print "Enter drug: "
          send_message(choice)
        when "c"
          @server.puts("exit")
        else
          puts "Unknown option! Please select (a) (b) or (c)"
          sleep 1
          system("clear")
          self.render_menu

      end
      receive_message
      @response.join

    end
  end


  def send_message(choice)
    @request = Thread.new do
      loop {
        # write as much as you want, read from console with the enter key, send message to the server
        msg = gets.chomp

        if msg == "back"
          system('clear')

          # break from loop
          break
        else
          # check choice to determine what to send
          if choice.eql?("a")
            # send message with dic- as identifier
            @server.puts(msg.insert(0, "dic-"))
          else
            @server.puts(msg.insert(0, "drg-"))
          end

        end

      }
      render_menu
    end
  end

  def receive_message
    @response = Thread.new do
      loop {
        #  listen for ever. Listen the server responses show them in console
        msg = @server.gets.chomp
        # dictionary result has dic- appended check if dictionary
        if msg.slice(0..3).eql?("dic-")
          puts "#{msg[4..-1]}  \n\n"
          print "Enter word: "

          # check if response has drg- appended if drugs
        elsif msg.slice(0..3).eql?("drg-")
          puts "#{msg[4..-1]}  \n\n"
          print "Enter drug: "
        elsif msg == "Bye!"
          puts msg
          break
        else
          puts msg
        end

      }
    end
  end
end

server = TCPSocket.new("127.0.0.1", 3000)
Client.new(server)
