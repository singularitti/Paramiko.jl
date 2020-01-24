__precompile__() # this module is safe to precompile

using Pkg

ENV["PYTHON"]=""
Pkg.build("PyCall")

using PyCall

export paramiko

const paramiko = PyNULL()

function __init__()
    copy!(paramiko, pyimport("paramiko"))
end
