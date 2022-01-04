
#=
This was fun. Learned some nice maths stuff about the median / mean that
makes a lot of intuitive sense.
A great explainer - https://ram.rachum.com/median/
=#

##
pwd()
cd("7/")

##
input = readlines("input.txt")
input = parse.(Int16, split(input[1], ","))

## P1
using StatsBase

value = cld(median(input), 1)
Int(sum(abs.(input .- value)))

## P2
# import Pkg
# Pkg.add("Plots")
using Plots

function compute_cost(x::Int)
    sum(abs.(input .- x) .* (abs.(input .- x) .+ 1) ./ 2)
end

x = 0:1:2000
y = compute_cost.(x)
x[argmin(y)]

plot(x, y)

Int(compute_cost(x[argmin(y)]))