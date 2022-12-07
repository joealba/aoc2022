#!/usr/bin/env ruby

require 'byebug'

# any extra cmd line args will run against the sample input file
filename = ARGV[0].nil? ? "input.txt" : "sample_input.txt"

################################################################

def range_to_set(range)
  Range.new(*range.split('-')).entries
end

def range_wholly_included?(range1, range2)
  range1.all? { |i| range2.include?(i) }
end

def either_range_wholly_included?(range1, range2)
  range_wholly_included?(range1, range2) || range_wholly_included?(range2, range1)
end


total = 0
File.readlines(filename).each do |line|
  ranges = line.chomp.split(',').map { |range| range_to_set(range) }

  total += 1 if either_range_wholly_included?(ranges[0], ranges[1])
end

puts "Part 1: #{total}"

total = 0
File.readlines(filename).each do |line|
  ranges = line.chomp.split(',').map { |range| range_to_set(range) }

  total += 1 if ranges[0].intersection(ranges[1]).length > 0
end

puts "Part 2: #{total}"
