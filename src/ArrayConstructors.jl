module ArrayConstructors

import Compat.uninitialized

import Base: Array, Vector, Matrix

# constructors that take a value and dims
Array(x::T, dims::Dims{N}) where {T,N} = Array{T,N}(x, dims)
Array{T}(x, dims::Dims{N}) where {T,N} = Array{T,N}(x, dims)
function Array{T,N}(x, dims::Dims{N}) where {T,N}
    A = Array{T,N}(uninitialized, dims)
    for i in eachindex(A)
        A[i] = copy(x)
    end
    return A
end
# Vector and Matrix need special treatment
Vector(x::T, dims::Dims{1}) where {T} = Vector{T}(x, dims)
Matrix(x::T, dims::Dims{2}) where {T} = Matrix{T}(x, dims)

# constructors that take an iterable with size
Array(x::AbstractArray{T,N}) where {T,N} = Array{T,N}(x)
Array{T}(x::AbstractArray{S,N}) where {T,S,N} = Array{T,N}(x)
Array{T,N}(x::AbstractArray{S,N}) where {T,S,N} = Array{T,N}(uninitialized, size(x)) .= x
# Vector and Matrix need special treatment
Vector(x::AbstractVector{T}) where {T} = Vector{T}(x)
Matrix(x::AbstractMatrix{T}) where {T} = Matrix{T}(x)

# ambiguities with Base
Vector(x::Vector{T}) where {T} = Vector{T}(x)
Matrix(x::Matrix{T}) where {T} = Matrix{T}(x)

end # module
