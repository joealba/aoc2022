#!/usr/bin/env ruby

require 'byebug'

# any extra cmd line args will run against the sample input file
filename = ARGV[0].nil? ? "input.txt" : "sample_input.txt"

################################################################

PRIORITY_SCORES = [('a'..'z').entries + ('A'..'Z').entries].flatten.zip((1..52).entries).to_h

def compartments_from_line(line)
  chars = line.chars
  half = chars.length / 2
  [chars.slice(0, half), chars.slice(half, chars.length)]
end

priority_total = 0
File.readlines(filename).each do |line|
  compartments = compartments_from_line(line)
  intersection = compartments.first.intersection(compartments.last)
  priority_total += intersection.map { |char| PRIORITY_SCORES[char] }.sum
end

puts "Part 1: #{priority_total}"


priority_total = 0
File.readlines(filename).each_slice(3) do |group|
  sacks = group.map { |line| line.chomp.chars }
  intersection = sacks.first.intersection(sacks[1], sacks[2])
  priority_total += intersection.map { |char| PRIORITY_SCORES[char] }.sum
end

puts "Part 2: #{priority_total}"
