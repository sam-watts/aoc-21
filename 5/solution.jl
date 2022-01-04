##
pwd()
cd("5/")

## P1
input = readlines("input.txt")
all_points = []

for line in input
    origin, dest = split(line, " -> ")
    x_origin, y_origin = parse.(Int32, split(origin, ","))
    x_dest, y_dest = parse.(Int32, split(dest, ","))

    if x_dest == x_origin
        println("Line is vertical")
        stride = y_origin > y_dest ? -1 : 1
        points = [(x_dest, y_val) for y_val in y_origin:stride:y_dest]

    elseif y_dest == y_origin
        println("Line is horizontal")
        stride = x_origin > x_dest ? -1 : 1
        points = [(x_val, y_dest) for x_val in x_origin:stride:x_dest]

    else
        println("Line is not vertical or horizontal")
        continue
    end
    all_points = vcat(all_points, points)

end


using StatsBase

counts = countmap(all_points)
sum([value > 1 ? 1 : 0 for value in values(counts)])

## P2
all_points = []

for line in input
    origin, dest = split(line, " -> ")
    x_origin, y_origin = parse.(Int32, split(origin, ","))
    x_dest, y_dest = parse.(Int32, split(dest, ","))

    if x_dest == x_origin
        println("Line is vertical")
        stride = y_origin > y_dest ? -1 : 1
        points = [(x_dest, y_val) for y_val in y_origin:stride:y_dest]

    elseif y_dest == y_origin
        println("Line is horizontal")
        stride = x_origin > x_dest ? -1 : 1
        points = [(x_val, y_dest) for x_val in x_origin:stride:x_dest]

    else
        println("Line 45 degree horizontal")
        x_stride = x_origin > x_dest ? -1 : 1
        y_stride = y_origin > y_dest ? -1 : 1
        x_points = [x_val for x_val in x_origin:x_stride:x_dest]
        y_points = [y_val for y_val in y_origin:y_stride:y_dest]
        points  = collect(zip(x_points, y_points))
    end
    all_points = vcat(all_points, points)

end

using StatsBase

counts = countmap(all_points)
sum([value > 1 ? 1 : 0 for value in values(counts)])