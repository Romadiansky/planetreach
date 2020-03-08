require "socket"
server = TCPServer.new 8765

while session = server.accept
  request = session.gets
  puts request

  unless request.nil?

    fileName = request.split(" ")[1]
    if fileName == "/"
      fileName = "/index.html"
    end

    begin
      data = File.open(__dir__ + "/public" + fileName).read

      session.print("HTTP/1.1 200 OK\r\n")
      session.print("Content-Type: text/html\r\n")
      session.print("\r\n")
      session.print(data)

    rescue
      session.print("HTTP/1.1 404 NOT FOUND\r\n")
      session.print("Content-Type: text/html\r\n")
      session.print("\r\n")
      session.print("you suck")
    end

  end

  session.close
end