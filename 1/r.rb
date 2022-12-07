#!/usr/bin/env ruby

# any extra cmd line args will run against the sample input file
filename = ARGV[0].nil? ? "input.txt" : "sample_input.txt"

elf_calories = File.read(filename).split(/\n{2}/).map { |group| group.split(/\n/).map(&:to_i).sum }

puts "Part 1: #{elf_calories.max}"
puts "Part 2: #{elf_calories.max(3).sum}"
