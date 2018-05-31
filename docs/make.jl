using Documenter, ScatteredInterpolation

makedocs(
    format = :html,
    sitename = "ScatteredInterpolation.jl",
    pages = [
        "Home" => "index.md",
        "Supported methods" => "methods.md",
        "API" => "api.md",
    ]
)

deploydocs(
    repo = "github.com/eljungsk/ScatteredInterpolation.jl.git",
    target = "build",
    julia = "0.6",
    deps = nothing,
    make = nothing,
)
