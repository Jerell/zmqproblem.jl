reqbody = "{\"components\": [{ \"ID\": \"1\", \"name\": \"n1\", \"outlets\": [], \"type\": \"t1\" }],\"bathymetries\": {\"1\":[{ \"x\": \"0\", \"y\": \"0\" }]}}"

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

body = JSON3.read(reqbody, ReqBody; parsequoted=true)
JSON3.pretty(body)

println("")


for (pipeid, coords) in body.bathymetries
    println("$pipeid $coords")
end