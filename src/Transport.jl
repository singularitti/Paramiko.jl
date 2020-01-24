module transport

using PyCall: PyObject, PyAny, pycall

import ..paramiko
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

PyCall.PyObject(f::Transport) = getfield(f, :o)
Base.convert(::Type{Transport}, o::PyObject) = Transport(o)
Base.:(==)(f::Transport, g::Transport) = PyObject(f) == PyObject(g)
Base.:(==)(f::Transport, g::PyObject) = PyObject(f) == g
Base.:(==)(f::PyObject, g::Transport) = f == PyObject(g)
Base.hash(f::Transport) = hash(PyObject(f))
PyCall.pycall(f::Transport, args...; kws...) = pycall(PyObject(f), args...; kws...)
(f::Transport)(args...; kws...) = pycall(PyObject(f), PyAny, args...; kws...)
Base.Docs.doc(f::Transport) = Base.Docs.doc(PyObject(f))
# Code from https://github.com/JuliaPy/PyPlot.jl/blob/6b38c75/src/PyPlot.jl#L65-L71
Base.getproperty(f::Transport, s::Symbol) = getproperty(PyObject(f), s)
Base.getproperty(f::Transport, s::AbstractString) = getproperty(PyObject(f), s)
Base.setproperty!(f::Transport, s::Symbol, x) = setproperty!(PyObject(f), s, x)
Base.setproperty!(f::Transport, s::AbstractString, x) = setproperty!(PyObject(f), s, x)
PyCall.hasproperty(f::Transport, s::Symbol) = hasproperty(PyObject(f), s)
Base.propertynames(f::Transport) = propertynames(PyObject(f))
Base.haskey(f::Transport, x) = haskey(PyObject(f), x)

# Public API
Base.close(f::Transport) = PyObject(f).close()
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
