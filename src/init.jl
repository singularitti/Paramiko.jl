__precompile__() # this module is safe to precompile

using PyCall: PyNULL, PyError, pyimport
using VersionParsing: vparse

export paramiko

const paramiko = PyNULL()

function __init__()
    try
        copy!(paramiko, pyimport("paramiko"))
    catch e
        e isa PyError && println("`paramiko` is not found! I will try to install it!")
        try
            @eval using Pkg
            haskey(Pkg.installed(), "Conda") || @eval Pkg.add("Conda")
        catch
            println("Installing `Conda.jl` failed! Please install by yourself!")
            rethrow()
        end
        try
            @eval using Conda
            Conda.add("paramiko")
        catch
            println("Installing `paramiko` failed! Please try by yourself!")
            rethrow()
        end
    end
    # Code from https://github.com/JuliaPy/PyPlot.jl/blob/caf7f89/src/init.jl#L168-L173
    vers = paramiko.__version__
    global version = try
        vparse(vers)
    catch
        v"0.0.0" # fallback
    end
end
