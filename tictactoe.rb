require './gameboard.rb'
require './colorization.rb'
require "pry"

class Game

  # initialise les joueurs avec les noms Player_one et two.
  def initialize (player1 = "Player_One", player2 = "Player_two")
    @player1 = Players.new (player1)
    @player2 = Players.new (player2)
    @board = Board.new
    @players =[@player1, @player2]
    @who_play=whos_first
    @game_played = 0 
  end

  # défini celui qui commence au hasard
  def whos_first
    @players.sample
  end

  # défini qui doit jouer
  def next_player
    if @players[0] == @who_play
      @players[1]
    else
      @players[0]
    end
  end

  # affiche le score de chaque joueur
  def score
    if @player1.victory_count > @player2.victory_count
      print " #{@player1.name} mène avec #{@player1.victory_count} victoires."
      puts " #{@player2.name} a quand a lui #{@player2.victory_count} victoires. "
    elsif @player2.victory_count > @player1.victory_count
      print " #{@player2.name} mène avec #{@player2.victory_count} victoires."
      puts " #{@player1.name} a quand a lui #{@player1.victory_count} victoires. "
    else 
      puts "Les deux joueurs sont à égalité avec #{@player1.victory_count} victoires."
    end
  end

  # contient le schéma du jeu
  def play
    puts "Début de la partie. Voici le plateau de jeu:"
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
        @who_play.victory_count > @player2.victory_count += 1
      elsif turn_played == 9
        @board.game_not_finished=false
        puts "Le jeu est une égalité"
      else
        @who_play=next_player
      end
    end
  end

  # à utiliser pour lancer une partie. Réinitialise le tableau. Affiche le score toutes les 5 parties
  def new_game
    @board = Board.new
    play
    @game_played += 1
    if @game_played % 5 ==0
      score
    end
  end

end

def perform
  game1 = Game.new
  game_continue="Y"
  while game_continue =~ /Y/i
    game1.new_game
    puts "Voulez-vous continuer à jouer? (Y/N)"
    print ">"
    game_continue = gets.chomp
  end 
  puts "Voici le score final:"
  game1.score
end


binding.pry