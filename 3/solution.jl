##
pwd()
cd("3/")

## Read Data
input = readlines("input.txt")

## 

x = zeros(Int8, length(input),length(input[1]),)

##
for i in 1:length(input)
    row = parse.(Int8, split(input[i], ""))
    x[i, :] = row
end

## P1

mean_bits = sum(x, dims=1) / 1000 
gamma_rate = mean_bits .> 0.5
epsilon_rate = mean_bits .<0.5

# many thanks to https://discourse.julialang.org/t/parse-an-array-of-bits-bitarray-to-an-integer/42361
function bitarr_to_int(arr::Vector{Int8})
    return sum(arr .* (2 .^ collect(length(arr)-1:-1:0)))
end


answer = bitarr_to_int(gamma_rate[:]) * bitarr_to_int(epsilon_rate[:])
println(answer)

## P2
using Statistics

function find_rating(type, x)
    default_keep = type == "oxygen_generator" ? 1 : 0
    global_indices = 1:size(x)[1]
    for (i, col) in enumerate(eachcol(x))
        valid_numbers = col[global_indices]
        print("iteration $i\n")
        # early exit if only one element remaining - we take this one
        if length(valid_numbers) == 1
            println("take final value, index = $global_indices")
            break
        end

        avg_value = mean(valid_numbers)

        # if values are equally common, we keep the default number depending on the type
        if avg_value == 0.5
            local_indices = findall(x->x==default_keep, valid_numbers)
            global_indices = global_indices[local_indices]
            println("value counts equal - keeping $default_keep")
            println("starting bits $valid_numbers")
            println("local indices $local_indices")
            println("global indices: $global_indices")
            println("--- iter end ---")
            continue
        end
        
        # for co2_scrubber, we keep values which are the least common overall
        if type == "co2_scrubber" 
            least_common = avg_value < 0.5
            println("least common value: $least_common")
            local_indices = findall(x->x==least_common, valid_numbers)
            global_indices = global_indices[local_indices]
        # for oxygen_generator, we keep values which are the most common overall
        elseif type == "oxygen_generator"
            most_common = avg_value > 0.5
            println("most common value: $most_common")
            local_indices = findall(x->x==most_common, valid_numbers)
            global_indices = global_indices[local_indices]
        end
        println("starting bits $valid_numbers")
        println("local indices $local_indices")
        println("global indices: $global_indices")
        println("--- iter end ---")

    end
    println("Binary value: $(x[global_indices, :])")

    bitarr_to_int(x[global_indices, :][:])
end

find_rating("co2_scrubber", x) * find_rating("oxygen_generator", x)