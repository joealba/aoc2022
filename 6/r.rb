#!/usr/bin/env ruby

CHUNK_SIZE = 14

# any extra cmd line args will run against the sample input file
filename = ARGV[0].nil? ? "input.txt" : "sample_input.txt"

sample = File.read(filename)

i = 0
sample.split('').each_cons(CHUNK_SIZE) { |chunk| break if chunk == chunk.uniq; i += 1; }
puts i + CHUNK_SIZE
