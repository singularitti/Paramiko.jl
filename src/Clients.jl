module Clients

# Import standard libraries
using Sockets: TCPSocket, UDPSocket
# Import third-party packages
using PyCall: PyObject, PyAny, pycall
# Import local modules
import ..paramiko
# Extending methods
import Sockets
import PyCall

export SSHClient, SFTPClient
export exec_command,
    gethostkeys,
    gettransport,
    invokeshell,
    loadhostkeys,
    load_system_host_keys,
    opensftp,
    chdir

# Wrapper around `paramiko.client.SSHClient`
mutable struct SSHClient
    o::PyObject
end
SSHClient() = SSHClient(paramiko.SSHClient())

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
SFTPClient(socket::Union{TCPSocket,UDPSocket}) = SFTPClient(paramiko.sftp_client.SFTPClient(socket))

Base.Filesystem.cd(f::SFTPClient, path = nothing) = PyObject(f).chdir(path)
chdir(f::SFTPClient, path = nothing) = PyObject(f).chdir(path)
Base.Filesystem.chmod(f::SFTPClient, path::AbstractString, mode::Integer) = PyObject(f).chmod(path, mode)
Base.Filesystem.chown(f::SFTPClient, path::AbstractString, uid::Integer, gid::Integer) = PyObject(f).chown(path, uid, gid)
Base.get(f::SFTPClient, remotepath, localpath, callback = nothing) = PyObject(f).get(remotepath, localpath, callback)
Base.Filesystem.pwd(f::SFTPClient) = PyObject(f).getcwd()
getcwd(f::SFTPClient) = PyObject(f).getcwd()
Base.Filesystem.readdir(f::SFTPClient, dir::AbstractString = ".") = PyObject(f).listdir(dir)
listdir(f::SFTPClient, dir::AbstractString = ".") = PyObject(f).listdir(dir)
Base.Filesystem.mkdir(f::SFTPClient, path::AbstractString; mode::Unsigned = 0o511) = PyObject(f).mkdir(path, mode)
Base.put!(f::SFTPClient, localpath, remotepath, callback = nothing, confirm = true) = PyObject(f).put(localpath, remotepath, callback, confirm)

for T in (:SSHClient, :SFTPClient)
    eval(
        quote
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
            # Common methods
            Base.close(f::$T) = PyObject(f).close()
        end,
    )
end

end # module Clients
