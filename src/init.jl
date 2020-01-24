__precompile__() # this module is safe to precompile

using PyCall

export paramiko

const paramiko = PyNULL()

function __init__()
    copy!(paramiko, pyimport("paramiko"))
    # Code from https://github.com/JuliaPy/PyPlot.jl/blob/caf7f89/src/init.jl#L168-L173
    vers = paramiko.__version__
    global version = try
        vparse(vers)
    catch
        v"0.0.0" # fallback
    end
end
