module transport

# Import third-party packages
using PyCall: PyObject, PyAny, pycall
# Import local modules
using Paramiko: paramiko, @pyinterface
# Extending methods
import Sockets
import PyCall

export Transport
export add_server_key, auth_password, auth_publickey, is_active, is_authenticated

# Code from https://github.com/JuliaPy/PyPlot.jl/blob/6b38c75/src/PyPlot.jl#L49-L62
# Wrapper around `paramiko.client.Transport`
mutable struct Transport
    o::PyObject
    function Transport(
        sock;
        default_window_size = 2097152,
        default_max_packet_size = 32768,
        gss_kex = false,
        gss_deleg_creds = true,
        disabled_algorithms = nothing,
    )
        return new(paramiko.transport.Transport(
            sock,
            default_window_size,
            default_max_packet_size,
            gss_kex,
            gss_deleg,
            disabled_algorith,
        ))
    end
end

@pyinterface Transport
Sockets.connect(f::Transport, args...; kws...) = PyObject(f).connect(args...; kws...)
Sockets.accept(f::Transport, timeout = nothing) = PyObject(f).accept(timeout)

add_server_key(f::Transport, key) = PyObject(f).add_server_key(key)
auth_password(f::Transport, username, password, event = nothing, fallback = true) =
    PyObject(f).auth_password(username, password, event, fallback)
auth_publickey(f::Transport, username, key, event = nothing) =
    PyObject(f).auth_publickey(username, key, event)
is_active(f::Transport) = PyObject(f).is_active()
is_authenticated(f::Transport) = PyObject(f).is_authenticated()

end # module transport
