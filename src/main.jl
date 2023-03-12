push!(LOAD_PATH, @__DIR__)

using BinaryHopfieldNetworks
using Plots: heatmap, plot, Plot


_heatmap(state::Vector{Int})::Plot = 
    let n = floor(Int, sqrt(length(state)))
        heatmap(
            reshape(state, n, n),
            aspect_ratio = :equal,
            c = :grays,
            legend = false
        )
    end


function main()

    patterns_9 = [
        [   # cross
            1, -1,  1,
           -1,  1, -1,
            1, -1,  1
        ],
        [   # circle
            1,  1, 1,
            1, -1, 1,
            1,  1, 1
        ]
    ]

    patterns_25 = (
        [   # cross
            1, -1, -1, -1,  1,
           -1,  1, -1,  1, -1, 
           -1, -1,  1, -1, -1,
           -1,  1, -1,  1, -1,
            1, -1, -1, -1,  1
        ],
        [   # circle
            1,  1,  1,  1, 1,
            1, -1, -1, -1, 1,
            1, -1, -1, -1, 1,
            1, -1, -1, -1, 1,
            1,  1,  1,  1, 1
        ], 
    )

    patterns = patterns_25

    network = HopfieldNetwork(reduce(hcat, patterns))

    test_input = rand((-1, 1), length(patterns[1]))
    @time output, energies = process(network, test_input, 5)

    plot(
        _heatmap(test_input),
        _heatmap(output),
        layout = 2
    ) |> display

    display(energies)

end


main()
