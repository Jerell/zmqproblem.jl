using ZMQ

context = Context()

# Socket to talk to server
println("Connecting to hello world server...")
socket = Socket(context, REQ)
ZMQ.connect(socket, "tcp://localhost:3000")

reqbody = "{\"components\": []}"


for request in 1:10
    println("Sending request $request ...")
    ZMQ.send(socket, reqbody)

    # # Get the reply.
    message = String(ZMQ.recv(socket))
    println("Received reply $request [ $message ]")
end

# Making a clean exit.
ZMQ.close(socket)
ZMQ.close(context)