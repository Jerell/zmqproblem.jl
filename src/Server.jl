module Server

export start

using ZMQ
using JSON3
using StructTypes

struct Component
    ID::String
end

struct ReqBody
    components::Array{Component}
end

StructTypes.StructType(::Type{ReqBody}) = StructTypes.Struct()

function start()
    context = Context()
    socket = Socket(context, REP)
    ZMQ.bind(socket, "tcp://*:3000")
    println("starting socket server")

    while true
        # Wait for next request from client
        message = String(ZMQ.recv(socket))
        println("Received request: $message")

        body = JSON3.read(message, ReqBody; parsequoted=true)
        JSON3.pretty(body)

        response = length(body.components)
        println("\nresponse:")
        println(response)
        # Send reply back to client
        ZMQ.send(socket, response)
    end

    println("stopping")
    ZMQ.close(socket)
    ZMQ.close(context)
end


end