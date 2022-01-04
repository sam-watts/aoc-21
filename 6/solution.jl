#=
I gave in far too quickly on P2, which is a shame as it would
have been nice to come up with that solution myself! On the other
hand I may well have been stuck for days...
Thank you random redditor - https://www.reddit.com/r/adventofcode/comments/raztqj/2021_day_6_part_1julia_solution_using_dynamical/
=#

##
pwd()
cd("6/")

##
input = readlines("input.txt")
input = parse.(Int8, split(input[1], ","))

## P1

num_days = 80
state = input
new_fish_timer = 8
fish_timer = 6

mutable struct Lanternfish
    internal_timer::Int8
end

## 
num_days = 80
all_fish = [Lanternfish(x) for x in input]

while num_days > 0
    _ = [fish.internal_timer -= 1 for fish in all_fish]    
    
    for fish in all_fish
        if fish.internal_timer < 0
            fish.internal_timer = fish_timer
            push!(all_fish, Lanternfish(new_fish_timer))
        end
    end


    num_days -= 1
end

length(all_fish)

## P2
using LinearAlgebra
using StatsBase

A = hcat(Vector([0,0,0,0,0,0,1,0,1]), Matrix(I, 9, 9)[:, 1:end-1])
base_pop = countmap(input)
base_pop = [get(base_pop, x, 0) for x in 0:8]

sum((A ^ 80) * base_pop)
sum((A ^ 256) * base_pop)