# Paramiko

|                                 **Documentation**                                  |                                                                                                 **Build Status**                                                                                                 |                                        **Others**                                         |
| :--------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------: |
| [![Stable][docs-stable-img]][docs-stable-url] [![Dev][docs-dev-img]][docs-dev-url] | [![Build Status][gha-img]][gha-url] [![Build Status][appveyor-img]][appveyor-url] [![Build Status][cirrus-img]][cirrus-url] [![pipeline status][gitlab-img]][gitlab-url] [![Coverage][codecov-img]][codecov-url] | [![GitHub license][license-img]][license-url] [![Code Style: Blue][style-img]][style-url] |

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://singularitti.github.io/Paramiko.jl/stable
[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://singularitti.github.io/Paramiko.jl/dev
[gha-img]: https://github.com/singularitti/Paramiko.jl/workflows/CI/badge.svg
[gha-url]: https://github.com/singularitti/Paramiko.jl/actions
[appveyor-img]: https://ci.appveyor.com/api/projects/status/github/singularitti/Paramiko.jl?svg=true
[appveyor-url]: https://ci.appveyor.com/project/singularitti/Paramiko-jl
[cirrus-img]: https://api.cirrus-ci.com/github/singularitti/Paramiko.jl.svg
[cirrus-url]: https://cirrus-ci.com/github/singularitti/Paramiko.jl
[gitlab-img]: https://gitlab.com/singularitti/Paramiko.jl/badges/main/pipeline.svg
[gitlab-url]: https://gitlab.com/singularitti/Paramiko.jl/-/pipelines
[codecov-img]: https://codecov.io/gh/singularitti/Paramiko.jl/branch/main/graph/badge.svg
[codecov-url]: https://codecov.io/gh/singularitti/Paramiko.jl
[license-img]: https://img.shields.io/github/license/singularitti/Paramiko.jl
[license-url]: https://github.com/singularitti/Paramiko.jl/blob/main/LICENSE
[style-img]: https://img.shields.io/badge/code%20style-blue-4495d1.svg
[style-url]: https://github.com/invenia/BlueStyle

The code, which is [hosted on GitHub](https://github.com/singularitti/Paramiko.jl), is tested
using various continuous integration services for its validity.

This repository is created and maintained by
[@singularitti](https://github.com/singularitti), and contributions are highly welcome.

## Package features

`Paramiko.jl` is a Foreign Function Interface (FFI) package for Julia, bridging the
capabilities of the renowned Python package, Paramiko. With `Paramiko.jl`, Julia
developers can directly utilize the robustness of Paramiko's SSHv2 protocol implementation
without leaving the Julia environment.

1. **SSHv2 Protocol in Julia**: Seamlessly use the SSHv2 protocol, implemented by
   `paramiko`, within Julia.
2. **Client and Server Functionality**: Both client and server sides of the SSH protocol are
   available, giving you versatility in SSH operations.
3. **Foundation for High-Level SSH Operations**: Built upon the same foundation as the
   high-level SSH library, [Fabric](https://fabfile.org/). This provides potential pathways
   for integrating advanced functionalities in the future.
4. **Advanced/low-level Primitives**: For those requiring a deeper dive into SSH
   functionalities, `Paramiko.jl` exposes the advanced and low-level primitives from
   `paramiko`.
5. **In-Python SSHD**: Run an in-Python sshd directly from Julia, offering an integrated
   solution for SSH server deployment and testing.

## Installation

The package can be installed with the Julia package manager.
From [the Julia REPL](https://docs.julialang.org/en/v1/stdlib/REPL/), type `]` to enter
the [Pkg mode](https://docs.julialang.org/en/v1/stdlib/REPL/#Pkg-mode) and run:

```julia-repl
pkg> add Paramiko
```

Or, equivalently, via [`Pkg.jl`](https://pkgdocs.julialang.org/v1/):

```julia
julia> import Pkg; Pkg.add("Paramiko")
```

## Documentation

- [**STABLE**][docs-stable-url] — **documentation of the most recently tagged version.**
- [**DEV**][docs-dev-url] — _documentation of the in-development version._

## Project status

The package is developed for and tested against Julia `v1.6` and above on Linux, macOS, and
Windows.

## Questions and contributions

You can post usage questions on
[our discussion page](https://github.com/singularitti/Paramiko.jl/discussions).

We welcome contributions, feature requests, and suggestions. If you encounter any problems,
please open an [issue](https://github.com/singularitti/Paramiko.jl/issues).
The [Contributing](@ref) page has
a few guidelines that should be followed when opening pull requests and contributing code.
