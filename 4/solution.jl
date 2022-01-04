#=
Arrays in Julia are nice
=#

##
pwd()
cd("4/")

##
input = readlines("input.txt")

number_list = parse.(Int8, split(input[1], ","))

# boards start from line 3, and are each 5 lines long
start_pointer = 3
span = 4
next = 6
boards = zeros(Int8, 5, 5, 0)
i = 0

input[start_pointer:start_pointer+span]

while start_pointer + span < length(input)
    board = input[start_pointer:start_pointer+span]
    board = hcat([[parse(Int8, num) for num in split(row, " ") if num != ""] for row in board]...)
    boards = cat(dims=3, boards, board) 
    start_pointer += next
    i += 1
end

## P1
boards_bool = similar(BitArray, axes(boards))
boards_bool .= 0

for j in number_list
    inds = findall(x->x==j, boards)
    boards_bool[inds] .= 1
    cols = sum(boards_bool, dims=1)
    rows = sum(boards_bool, dims=2)

    cols_bool = dropdims(sum(cols .== 5, dims=2), dims=(1,2))
    rows_bool = dropdims(sum(rows .== 5, dims=1), dims=(1,2))

    inds_col = findall(x->x>0, cols_bool)
    inds_row = findall(x->x>0, rows_bool)

    all_inds = vcat(inds_col, inds_row)

    if !isempty(all_inds)
        index = all_inds[1]
        println("Index of winning board: $index")
        println(sum(boards[:, :, index][.!boards_bool[:, :, index]]) * j)
        break
    end
end

## P2   
boards_bool = similar(BitArray, axes(boards))
boards_bool .= 0
all_inds = zeros(Int8, 0)
completed = zeros(Int8, 0)
j_at_completion = zeros(Int8, 0)

for j in number_list
    inds = findall(x->x==j, boards)
    boards_bool[inds] .= 1
    cols = sum(boards_bool, dims=1)
    rows = sum(boards_bool, dims=2)

    cols_bool = dropdims(sum(cols .== 5, dims=2), dims=(1,2))
    rows_bool = dropdims(sum(rows .== 5, dims=1), dims=(1,2))

    inds_col = findall(x->x>0, cols_bool)
    inds_row = findall(x->x>0, rows_bool)

    all_inds = vcat(inds_col, inds_row)
    newly_completed = setdiff(unique(all_inds), completed)

    if !isempty(newly_completed)
        completed = vcat(completed, newly_completed)
        j_at_completion = vcat(j_at_completion, repeat([j], length(newly_completed)))
    end

    if length(completed) == 99
        break
    end
end

index = completed[end]
println("Index of winning board: $index")
println(sum(boards[:, :, index][.!boards_bool[:, :, index]]) * j_at_completion[end])