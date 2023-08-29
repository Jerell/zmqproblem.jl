using ZMQ

context = Context()

# Socket to talk to server
println("Connecting to hello world server...")
socket = Socket(context, REQ)
ZMQ.connect(socket, "tcp://localhost:3000")

reqbody = "{\"components\": [{ \"ID\": \"1\", \"name\": \"n1\", \"outlets\": [], \"type\": \"t1\" }],\"bathymetries\": {\"1\":[{ \"x\": \"0\", \"y\": \"0\" }]}}"


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