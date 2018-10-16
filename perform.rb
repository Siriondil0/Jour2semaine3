# frozen_string_literal: true

require './tictactoe.rb'
require './gameboard.rb'
require './colorization.rb'
require "pry"
require "rubocop"

def perform
  game1 = Game.new
  game_continue = "Y"
  while game_continue =~ /Y/i
    game1.new_game
    puts "Voulez-vous continuer à jouer? (Y/N)"
    print ">"
    game_continue = gets.chomp
  end
  puts "Voici le score final:"
  game1.score
end

perform
