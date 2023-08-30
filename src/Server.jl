module Server

export start

using ZMQ
using JSON3
using StructTypes

struct Component
    ID::String
    name::String
    outlets::Array{String}
    type::String
end

struct XYPoint
    x::Float16
    y::Float16
end

struct ReqBody
    components::Array{Component}
    bathymetries::Dict{String,Array{XYPoint}}
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

        println("")
        for (pipeid, coords) in body.bathymetries
            println("$pipeid $coords")
        end

        response = string("num components: ", length(body.components))
        # Send reply back to client
        if isopen(socket)
            println("\nresponse:")
            println(response)
            ZMQ.send(socket, response)
            println("")
        else
            println("socket was closed")
            println(socket)
            println(context)
        end
    end

    println("stopping")
    ZMQ.close(socket)
    ZMQ.close(context)
end

end