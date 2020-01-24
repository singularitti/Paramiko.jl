__precompile__() # this module is safe to precompile

using PyCall

export paramiko

const paramiko = PyNULL()

function __init__()
    copy!(paramiko, pyimport("paramiko"))
end
