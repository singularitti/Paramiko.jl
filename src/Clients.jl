module Clients

# Import standard libraries
using Sockets: TCPSocket, UDPSocket
# Import third-party packages
using PyCall: PyObject, PyAny, pycall
# Import local modules
using Paramiko: paramiko, pyinterface
# Extending methods
import Sockets
import PyCall

export Tunnel, SSHClient, SFTPClient
export exec_command,
    gethostkeys,
    gettransport,
    invokeshell,
    loadhostkeys,
    load_system_host_keys,
    opensftp,
    chdir

mutable struct Tunnel
    o::PyObject
end
Tunnel(chanid::Integer) = Tunnel(paramiko.channel.Channel(chanid))

fileno(f::Tunnel) = PyObject(f).fileno()
invoke_shell(f::Tunnel, args...; kws...) = PyObject(f).invoke_shell(args...; kws...)

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

for T in (:Tunnel, :SSHClient, :SFTPClient)
    eval(pyinterface(T))
end

end # module Clients
