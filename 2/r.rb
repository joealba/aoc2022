#!/usr/bin/env ruby

PLAY_MAP = {
  'A' => :rock,
  'B' => :paper,
  'C' => :scissors,
  'X' => :rock,
  'Y' => :paper,
  'Z' => :scissors,
}

PLAY_SCORE = {
  rock: 1,
  paper: 2,
  scissors: 3,
}

WIN_MAP = {
  rock: :scissors,
  paper: :rock,
  scissors: :paper,
}

SCORE_MAP = {
  win: 6,
  draw: 3,
  loss: 0,
}

def play_outcome(player1, player2)
  if player1 == player2
    :draw
  elsif WIN_MAP[player1] == player2
    :win
  else
    :loss
  end
end

def string_to_play(string)
  PLAY_MAP[string]
end

def score_string_play(player1, player2)
  p1_play = string_to_play(player1)
  p2_play = string_to_play(player2)
  outcome = play_outcome(p1_play, p2_play)

  SCORE_MAP[outcome] + PLAY_SCORE[p1_play]
end

################################################################
# any extra cmd line args will run against the sample input file
filename = ARGV[0].nil? ? "input.txt" : "sample_input.txt"

scores = File.readlines(filename).map do |line|
  (player2, player1) = line.chomp.split(/ +/)
  score_string_play(player1, player2)
end

puts "Part 1: #{scores.sum}"
