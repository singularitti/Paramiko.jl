using Paramiko
using Documenter

makedocs(;
    modules=[Paramiko],
    authors="Qi Zhang <singularitti@outlook.com>",
    repo="https://github.com/singularitti/Paramiko.jl/blob/{commit}{path}#L{line}",
    sitename="Paramiko.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://singularitti.github.io/Paramiko.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/singularitti/Paramiko.jl",
)
