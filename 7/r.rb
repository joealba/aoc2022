#!/usr/bin/env ruby

require 'byebug'

# any extra cmd line args will run against the sample input file
filename = ARGV[0].nil? ? "input.txt" : "sample_input.txt"

@dir_stack = []
@dir_sizes = Hash.new(0)
@files = {}

def is_command?(line)
  line =~ /\A\$/
end

def process_command(line)
  command = line.split(/\s+/)
  command.shift # remove prompt

  case command.first
  when 'ls'
    #
  when 'cd'
    if command.last == '..'
      @dir_stack.pop
    elsif command.last == '/'
      @dir_stack = []
    else
      @dir_stack.push command.last
    end
  end
end

def dir_prefix(dir_stack)
  if dir_stack.empty?
    ""
  else
    "/" + dir_stack.join('/')
  end
end

def process_ls_line(line)
  pieces = line.split(/\s+/)
  if pieces.first =~ /\A\d+\z/
    filename = "#{dir_prefix(@dir_stack)}/#{pieces.last}"
    if !@files[filename]
      @files[filename] = pieces.first.to_i
      increment_dir_sizes(pieces.first.to_i)
    end
  else
    # just listing a directory name
  end
end

def increment_dir_sizes(size)
  stack = @dir_stack.dup
  while !stack.empty? do
    dir = dir_prefix(stack)
    @dir_sizes[dir] += size
    stack.pop
  end

  @dir_sizes['/'] += size
end

############################################################
File.readlines(filename).each do |line|
  if is_command?(line)
    process_command(line)
  else
    process_ls_line(line)
  end
end

part_1_sum = @dir_sizes.select {|k,v| v <= 100000}.values.sum
puts "Part 1: #{part_1_sum}"

current_free_space = (70000000 - @dir_sizes['/'])
free_space_needed = 30000000 - current_free_space

part_2_size = @dir_sizes.select {|k,v| v >= free_space_needed}.values.min
puts "Part 2: #{part_2_size}"
