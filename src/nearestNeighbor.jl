
export NearestNeighbor

"""
    NearestNeigbor()

Nearest neighbor interpolation.

"""
immutable NearestNeighbor <: InterpolationMethod end

immutable NearestNeighborInterpolant{T, TT, N} <: ScatteredInterpolant

    data::Array{T,N}
    tree::TT
end

@compat function interpolate{N}(nn::NearestNeighbor,
                     points::AbstractArray{<:Real,2},
                     samples::AbstractArray{<:Number,N};
                     metric = Euclidean())

    # Build a kd-tree of the points
    tree = KDTree(points, metric)

    return NearestNeighborInterpolant(samples, tree)
end

@compat function evaluate(itp::NearestNeighborInterpolant, points::AbstractArray{<:Real,2})

    # Get the indices for each points closest neighbor
    inds, _ = knn(itp.tree, points, 1)

    m = size(points, 2)
    n = size(itp.data, 2)
    values = zeros(eltype(itp.data), m, n)

    # knn returns a vector of vectors, so we need a loop
    for i in 1:m
        values[i, :] = itp.data[inds[i][1], :]
    end
    
    return values
end
