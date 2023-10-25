using Paramiko
using Documenter

DocMeta.setdocmeta!(Paramiko, :DocTestSetup, :(using Paramiko); recursive=true)

makedocs(;
    modules=[Paramiko],
    authors="singularitti <singularitti@outlook.com> and contributors",
    repo="https://github.com/singularitti/Paramiko.jl/blob/{commit}{path}#{line}",
    sitename="Paramiko.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://singularitti.github.io/Paramiko.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/singularitti/Paramiko.jl",
    devbranch="main",
)
