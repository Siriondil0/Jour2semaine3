# frozen_string_literal: true

require './gameboard.rb'
require './colorization.rb'
require "pry"
require "rubocop"

class Game
  # initialise les joueurs avec les noms Player_one et two.
  def initialize(player1 = "Player_One", player2 = "Player_two")
    @player1 = Players.new(player1)
    @player2 = Players.new(player2)
    @board = Board.new
    @players = [@player1, @player2]
    @who_play = whos_first
    @game_played = 0
    @board_cases_name = ["a1", "a2", "a3", "b1", "b2", "b3", "c1", "c2", "c3"]
  end

  # défini celui qui commence au hasard
  def whos_first
    @players.sample
  end

  # Prend le joueur qui ne joue pas
  def next_player
    if @players[0] == @who_play
      @players[1]
    else
      @players[0]
    end
  end

  # accorde correctement victoire selon le nombre de victoire
  def good_spelling(victory_number)
    if victory_number > 1
      "victoires"
    else
      "victoire"
    end
  end

  # affiche le score de chaque joueur
  def score
    if @player1.victory_count > @player2.victory_count
      print " #{@player1.name} mène avec #{@player1.victory_count} #{good_spelling(@player1.victory_count)}."
      puts " #{@player2.name} a quand a lui #{@player2.victory_count} #{good_spelling(@player2.victory_count)}. "
    elsif @player2.victory_count > @player1.victory_count
      print " #{@player2.name} mène avec #{@player2.victory_count} #{good_spelling(@player1.victory_count)}."
      puts " #{@player1.name} a quand a lui #{@player1.victory_count} #{good_spelling(@player2.victory_count)}. "
    else
      puts "Les deux joueurs sont à égalité avec #{@player1.victory_count} #{good_spelling(@player1.victory_count)}."
    end
  end

  # Renvoie l'index des cases
  # les cases sont au format a1, a2 ...
  def identify(string)
    @board_cases_name.index(string.downcase)
  end

  # contient le schéma du jeu
  def play
    puts "Début de la partie. Voici le plateau de jeu:"
    @board.game_not_finished = true
    turn_played = 0
    @board.display
    puts "Les cases sont au format 'A1', 'B2', etc..."
    while @board.game_not_finished
      puts
      puts "Tour #{turn_played+1}"
      puts "#{@who_play.name}, à toi de jouer. Donne la case que tu veux jouer."
      print ">"
      case_played = gets.chomp
      until @board.valid?(identify(case_played))
        puts "La case est invalide, donnes-en une autre"
        print ">"
        case_played = gets.chomp
      end
      while @board.occupied?(identify(case_played))
        puts "La case est occupée, donnes-en une autre"
        print ">"
        case_played = gets.chomp
      end
      @board.change_value(identify(case_played), @who_play.symbol)
      @board.display
      turn_played += 1
      if @board.three_adjacent_symbol?
        @board.game_not_finished = false
        puts "#{@who_play.name} a gagné le jeu"
        @who_play.victory_count += 1
      elsif turn_played == 9
        @board.game_not_finished = false
        puts "Le jeu est une égalité"
      else
        @who_play = next_player
      end
    end
  end

  # à utiliser pour lancer une partie. Réinitialise le tableau. Affiche le score toutes les 5 parties.
  # après la partie, remet le 1er joueur de la partie suivante au hasard
  def new_game
    @board = Board.new
    play
    @game_played += 1
    if (@game_played % 5).zero?
      score
    end
    @who_play = whos_first
  end
end
