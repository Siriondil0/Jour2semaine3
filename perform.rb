# frozen_string_literal: true

require './tictactoe.rb'
require './gameboard.rb'
require './colorization.rb'
require "pry"
require "rubocop"

#demande le nom des joueurs
def ask_name
  puts "Bienvenue dans ce jeu de morpions. Il se joue à deux. Veuillez entrer chacun votre tour votre nom."
  print "Nom du 1er joueur: >"
  name1 = gets.chomp
  print "Nom du 2nd joueur: >"
  name2 = gets.chomp
  puts
  [name1,name2]
end

# lance un jeu et continu a jouer si les joueurs le veulent
def perform
  name = ask_name
  game1 = Game.new(name[0],name[1])
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
