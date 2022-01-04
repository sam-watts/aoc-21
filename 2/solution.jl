##
pwd()
cd("2/")

##
input = readlines("input.txt")

## P1

x, y = 0, 0

for line in input 
    direction, amount = split(line, " ")
    amount = parse(Int64, amount)
    if direction == "forward"
        x += amount
    elseif direction == "down"
        y += amount
    elseif direction == "up"
        y -= amount
    end
end

x * y

## P2

x, y, aim = 0, 0, 0

for line in input 
    direction, amount = split(line, " ")
    amount = parse(Int64, amount)
    if direction == "forward"
        x += amount
        y += aim * amount
    elseif direction == "down"
        aim += amount
    elseif direction == "up"
        aim -= amount
    end
end

x * y
