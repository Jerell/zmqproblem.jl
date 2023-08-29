# repro

## start server

```bash
julia src/repro.jl
```

## start client

```bash
julia src/Client.jl
```

## expected output

```bash
% julia src/repro.jl
  Activating project at `~/Repos/Pace/zmqproblem.jl`
starting socket server
Received request: {"components": []}}
{
    "components": [
    ]
}
response:
0
ERROR: LoadError: ZMQ.StateError("Socket operation on non-socket")
Stacktrace:
 [1] _send(socket::ZMQ.Socket, zmsg::Base.RefValue{ZMQ._Message}, more::Bool)
   @ ZMQ ~/.julia/packages/ZMQ/lrABE/src/comm.jl:14
 [2] send(socket::ZMQ.Socket, data::Int64; more::Bool)
   @ ZMQ ~/.julia/packages/ZMQ/lrABE/src/comm.jl:45
 [3] send
   @ ~/.julia/packages/ZMQ/lrABE/src/comm.jl:42 [inlined]
 [4] start()
   @ Main.repro.Server ~/Repos/Pace/zmqproblem.jl/src/Server.jl:37
 [5] top-level scope
   @ ~/Repos/Pace/zmqproblem.jl/src/repro.jl:6
in expression starting at /Users/jerell/Repos/Pace/zmqproblem.jl/src/repro.jl:1
```
