module Client

using PyCall: PyObject, PyAny, pycall

import ..paramiko
# Extending methods
import Sockets
import PyCall

export SSHClient
export exec_command,
    gethostkeys, gettransport, invokeshell, loadhostkeys, load_system_host_keys, opensftp

# Code from https://github.com/JuliaPy/PyPlot.jl/blob/6b38c75/src/PyPlot.jl#L49-L62
# Wrapper around `paramiko.client.SSHClient`
mutable struct SSHClient
    o::PyObject
end
SSHClient() = SSHClient(paramiko.SSHClient())

PyCall.PyObject(f::SSHClient) = getfield(f, :o)
Base.convert(::Type{SSHClient}, o::PyObject) = SSHClient(o)
Base.:(==)(f::SSHClient, g::SSHClient) = PyObject(f) == PyObject(g)
Base.:(==)(f::SSHClient, g::PyObject) = PyObject(f) == g
Base.:(==)(f::PyObject, g::SSHClient) = f == PyObject(g)
Base.hash(f::SSHClient) = hash(PyObject(f))
PyCall.pycall(f::SSHClient, args...; kws...) = pycall(PyObject(f), args...; kws...)
(f::SSHClient)(args...; kws...) = pycall(PyObject(f), PyAny, args...; kws...)
Base.Docs.doc(f::SSHClient) = Base.Docs.doc(PyObject(f))
# Code from https://github.com/JuliaPy/PyPlot.jl/blob/6b38c75/src/PyPlot.jl#L65-L71
Base.getproperty(f::SSHClient, s::Symbol) = getproperty(PyObject(f), s)
Base.setproperty!(f::SSHClient, s::Symbol, x) = setproperty!(PyObject(f), s, x)
PyCall.hasproperty(f::SSHClient, s::Symbol) = hasproperty(PyObject(f), s)
Base.propertynames(f::SSHClient) = propertynames(PyObject(f))
Base.haskey(f::SSHClient, x) = haskey(PyObject(f), x)

Base.close(f::SSHClient) = f.o.close()
Sockets.connect(f::SSHClient, hostname, args...; kws...) = f.o.connect(hostname, args...; kws...)

exec_command(f::SSHClient, command::AbstractString, args...; kws...) = f.o.exec_command(command, args..., kws...)
exec_command(f::SSHClient, command::Base.AbstractCmd, args...; kws...) = exec_command(f, string(command), args...; kws...)
gethostkeys(f::SSHClient) = f.o.get_host_keys()
gettransport(f::SSHClient) = f.o.get_transport()
invokeshell(f::SSHClient, args...; kws...) = f.o.invoke_shell(args...; kws...)
loadhostkeys(f::SSHClient, filename::AbstractString) = f.o.load_host_keys(filename)
load_system_host_keys(f::SSHClient, filename::AbstractString) = f.o.load_system_host_keys(filename)
opensftp(f::SSHClient) = f.o.open_sftp()

end # module Client
