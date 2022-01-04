pwd()

cd("1")

input = readlines("input.txt")
input = parse.(Int64, input)


previous = 9999999
count = 0
for row in input
    if row > previous
        count += 1
    end
    previous = row
end

println("Part 1: ", count)

count = 0
for i in 1:length(input)
    j = i + 1
    furthest = j + 2
    
    if furthest > length(input)
        break
    end
    first_window = sum(input[i:i+2])
    second_window = sum(input[j:j+2])
    if first_window < second_window
        count += 1
    end
end

println("Part 2: ", count)
