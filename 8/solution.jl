##
pwd()
cd("8/")

##
input = readlines("input_test.txt")

## P1
using Base.Iterators
outputs = split.(last.(split.(input, " | ")), " ")

sum(in.(length.(collect(flatten(outputs))), tuple([2, 4, 3, 7])))

## P2
# using Pkg; Pkg.add("OrderedCollections")
using OrderedCollections

decode_map = [Char(x) => "NA" for x in 97:103]

code_lengths = Dict(
    2 => [1],
    3 => [7],
    4 => [4],
    5 => [2, 3, 5],
    6 => [0, 6, 9],
    7 => [8],
)

base_letter_map = Dict(
    0 => ["a", "b", "c", "e", "f", "g"],
    1 => ["c", "f"],
    2 => ["a", "c", "d", "e", "g"],
    3 => ["a", "c", "d", "f", "g"],
    4 => ["b", "c", "d", "f"],
    5 => ["a", "b", "d", "f", "g"],
    6 => ["a", "b", "d", "e", "f", "g"],
    7 => ["a", "c", "f"],
    8 => ["a", "b", "c", "d", "e", "f", "g"],
    9 => ["a", "b", "c", "d", "f", "g"],
)

letter_code_lengths = map(x -> (x[1]) => length(x[2]), collect(pairs(base_letter_map)))
attempt_order = sort(letter_code_lengths, by=x->x[2])

all_vals = split.(replace.(input, " | " => ""), " ")

# for val in all_vals
    lengths = length.(val)

    smallest_code = argmin(lengths)
    smallest_val = minimum(lengths)
    val[smallest_code]

# end