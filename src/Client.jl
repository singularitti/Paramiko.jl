module Client

using PyCall: PyObject, PyAny, pycall

import ..paramiko
# Extending methods
import Sockets
import PyCall

export SSHClient, SFTPClient
export exec_command,
    gethostkeys, gettransport, invokeshell, loadhostkeys, load_system_host_keys, opensftp

# Wrapper around `paramiko.client.SSHClient`
mutable struct SSHClient
    o::PyObject
end
SSHClient() = SSHClient(paramiko.SSHClient())

Base.close(f::SSHClient) = PyObject(f).close()
Sockets.connect(f::SSHClient, hostname, args...; kws...) = PyObject(f).connect(hostname, args...; kws...)

exec_command(f::SSHClient, command::AbstractString, args...; kws...) = PyObject(f).exec_command(command, args..., kws...)
exec_command(f::SSHClient, command::Base.AbstractCmd, args...; kws...) = exec_command(f, string(command), args...; kws...)
gethostkeys(f::SSHClient) = PyObject(f).get_host_keys()
gettransport(f::SSHClient) = PyObject(f).get_transport()
invokeshell(f::SSHClient, args...; kws...) = PyObject(f).invoke_shell(args...; kws...)
loadhostkeys(f::SSHClient, filename::AbstractString) = PyObject(f).load_host_keys(filename)
load_system_host_keys(f::SSHClient, filename = nothing) = PyObject(f).load_system_host_keys(filename)
opensftp(f::SSHClient) = PyObject(f).open_sftp()

mutable struct SFTPClient
    o::PyObject
end
SFTPClient() = SFTPClient(paramiko.SFTPClient())

for T in (:SSHClient, :SFTPClient)
    eval(quote
        # Code from https://github.com/JuliaPy/PyPlot.jl/blob/6b38c75/src/PyPlot.jl#L54-L62
        PyCall.PyObject(f::$T) = getfield(f, :o)
        Base.convert(::Type{$T}, o::PyObject) = $T(o)
        Base.:(==)(f::$T, g::$T) = PyObject(f) == PyObject(g)
        Base.:(==)(f::$T, g::PyObject) = PyObject(f) == g
        Base.:(==)(f::PyObject, g::$T) = f == PyObject(g)
        Base.hash(f::$T) = hash(PyObject(f))
        PyCall.pycall(f::$T, args...; kws...) = pycall(PyObject(f), args...; kws...)
        (f::$T)(args...; kws...) = pycall(PyObject(f), PyAny, args...; kws...)
        Base.Docs.doc(f::$T) = Base.Docs.doc(PyObject(f))
        # Code from https://github.com/JuliaPy/PyPlot.jl/blob/6b38c75/src/PyPlot.jl#L65-L71
        Base.getproperty(f::$T, s::Symbol) = getproperty(PyObject(f), s)
        Base.getproperty(f::$T, s::AbstractString) = getproperty(PyObject(f), s)
        Base.setproperty!(f::$T, s::Symbol, x) = setproperty!(PyObject(f), s, x)
        Base.setproperty!(f::$T, s::AbstractString, x) = setproperty!(PyObject(f), s, x)
        PyCall.hasproperty(f::$T, s::Symbol) = hasproperty(PyObject(f), s)
        Base.propertynames(f::$T) = propertynames(PyObject(f))
        Base.haskey(f::$T, x) = haskey(PyObject(f), x)
    end)
end

end # module Clients
