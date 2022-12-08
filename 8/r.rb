#!/usr/bin/env ruby

require 'matrix'

# any extra cmd line args will run against the sample input file
filename = ARGV[0].nil? ? "input.txt" : "sample_input.txt"

def coordinate_groups_to_check(matrix, x, y)
  [
    (y-1..0).map { |i| [x, i] }, #north
    (y+1..matrix.row_count-1).map { |i| [x, i] }, #south
    (x+1..matrix.column_count-1).map { |i| [i, y] }, # east
    (x-1..0).map { |i| [i, y] }, # west
  ].reject(&:empty?)
end

def visible_at_point(matrix, x, y)
  coordinate_groups_to_check(matrix, x, y).any? do |group|
    group.all? do |pt|
      matrix[x, y] > matrix[pt[0], pt[1]]
    end
  end
end

def num_edge_trees(matrix)
  matrix.column_count * 2 + (matrix.row_count - 2) * 2
end

matrix = Matrix[*File.readlines(filename).map(&:chomp).map{|line| line.chars.map(&:to_i)}]

total = 0
for x in 1..matrix.column_count-2 do
  for y in 1..matrix.row_count-2
    if visible_at_point(matrix, x, y)
      puts "visible"
      total += 1
    end
    puts
  end
end

puts total
