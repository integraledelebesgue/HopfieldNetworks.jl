module BinaryHopfieldNetworks
export HopfieldNetwork, process

using Random: rand
using LinearAlgebra: fillband!


struct HopfieldNetwork
    
    patterns::VecOrMat{Int}
    weights::Matrix{Float64}

    HopfieldNetwork(patterns::VecOrMat{Int})::HopfieldNetwork = 
        let n = size(patterns)[1]
            new(
                patterns, 
                fillband!(patterns * patterns' / n, 0.0, 0, 0)
            )
        end

end


function process(network::HopfieldNetwork, input::Vector{Int}, n_iterations::Int)::Tuple{Vector{Int}, Vector{Float64}}

    energies = []

    for _ in 1:n_iterations
        input = network.weights * input
        push!(energies, -0.5 * input' * network.weights * input)
        map!(sign, input, input)
    end

    return input, energies

end


end #module