using ArrayConstructors
using Compat.Test

@testset "constructors that take a scalar value and dims" begin
    @test Array(2.0, (2,2)) == fill(2.0, (2,2))
    @test Array{Float64}(2.0f0, (2,2)) == fill(2.0, (2,2))
    @test Array{Float64,2}(2.0f0, (2,2)) == fill(2.0, (2,2))
    @test Vector(2.0, (2,)) == fill(2.0, (2,))
    @test Matrix(2.0, (2,2)) == fill(2.0, (2,2))
end

@testset "constructors that take a non-scalar value and dims" begin
    A = rand(Float32, 2, 2)
    @test Array(A, (2,2)) == fill(A, (2,2))
    @test Array{Matrix{Float64}}(A, (2,2)) == fill(A, (2,2))
    @test Array{Matrix{Float64},2}(A, (2,2)) == fill(A, (2,2))
    @test Matrix(A, (2,2)) == fill(A, (2,2))

    # test for no aliasing
    B = Array(A, (2,2))
    @test all(x -> x !== A, B)
    @test all(x -> x  == A, B)
end

@testset "constructors that take an iterable with size" begin
    v = rand(Float32, 2)
    A = rand(Float32, 2, 2)
    @test Array(v) == v && Array(v) !== v
    @test Vector(v) == v && Vector(v) !== v
    @test Array(A) == A && Array(A) !== A
    @test Matrix(A) == A && Matrix(A) !== A
    @test Array{Float64}(v) == collect(Float64, v)
    @test Vector{Float64}(v) == collect(Float64, v)
    @test Array{Float64}(A) == collect(Float64, A)
    @test Matrix{Float64}(A) == collect(Float64, A)
    @test Array{Float64,1}(v) == collect(Float64, v)
    @test Array{Float64,2}(A) == collect(Float64, A)
end
