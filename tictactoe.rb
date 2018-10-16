require './gameboard.rb'
require './colorization.rb'
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
    @board.game_not_finished = true
    turn_played = 0
    @board.display
    while @board.game_not_finished
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
      @board.display
      turn_played += 1
      if @board.three_adjacent_symbol?
        @board.game_not_finished=false
        puts "#{@who_play.name} a gagné le jeu"
        @who_play.count_victory += 1
      elsif turn_played == 9
        @board.game_not_finished=false
        puts "Le jeu est une égalité"
      else
        @who_play=next_player
      end
    end
  end

  # à utiliser pour lancer une partie. Réinitialise le tableau
  def new_game
    @board = Board.new
    play
  end

end

# game1 = Game.new
# game1.new_game

binding.pry