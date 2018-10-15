require './gameboard.rb'
require "pry"

class Game
  #contient le jeux
  def initialize (player1 = "Player_One", player2 = "Player_two")
    @player1 = Players.new (player1)
    @player2 = Players.new (player2)
    @board = Board.new
    @players =[@player1, @player2]
    @who_play=whos_first
    
  end

  #défini celui qui commence
  def whos_first
    @players.sample
  end

  #défini qui doit jouer
  def next_player
    if @players[0] == @who_play
      @players[1]
    else
      @players[0]
    end
  end

  #contient le schéma du jeu
  def play
    game_not_finished = true
    turn_played = 0
    while game_not_finished
      puts "C'est au #{@who_play.name} de jouer. Veuillez dire sur quelle case vous voulez jouer."
      print ">"
      case_played=gets.chomp.to_i
      until @board.valid? (case_played.to_i) 
        puts "La case est invalide, donne-en une autre"
        print ">"
        case_played=gets.chomp.to_i
      end
      while @board.occupied? (case_played.to_i) 
        puts "La case est occupée, donne-en une autre"
        print ">"
        case_played=gets.chomp.to_i
      end
      @board.change_value(case_played,@who_play.symbol)
      turn_played += 1
      if @board.three_adjacent_symbol?
        game_not_finished=false
        puts "#{@who_play.name} a gagné le jeu"
        return @who_play
      elsif turn_played == 9
        game_not_finished=false
        puts "Le jeu est une égalité"
      else
        @who_play=next_player
      end
    end
  end

  binding.pry

end
