# frozen_string_literal: true

require "./colorization.rb"
require "pry"

# classe du plateau de jeu
class Board
  attr_accessor :cases, :game_not_finished

  # Contient 9 cases
  def initialize
    @cases = []
    9.times do
      @cases << BoardCase.new
    end
    @game_not_finished = false
  end

  # Affiche le @casesleau. On teste pour chaque case le symbole pour le coloriser de manière appropriée
  def display
    puts "     1   2   3"
    puts "   -------------"
    puts " A | #{colorize(@cases[0].value)} | #{colorize(@cases[1].value)} | #{colorize(@cases[2].value)} |"
    puts "   -------------"
    puts " B | #{colorize(@cases[3].value)} | #{colorize(@cases[4].value)} | #{colorize(@cases[5].value)} |"
    puts "   -------------"
    puts " C | #{colorize(@cases[6].value)} | #{colorize(@cases[7].value)} | #{colorize(@cases[8].value)} |"
    puts "   -------------"
  end

  # Colorise la valeur suivant la valeur de la case
  def colorize(val)
    if val == "="
      val.black
    elsif val == "X"
      val.blue.bold
    elsif val == "O"
      val.red.italic
    end
  end

  # Vérifie si la case existe (ie le nombre rentré est entre 0 et 8)
  def valid?(number)
    if number.nil?
      false
    else
      !@cases[number].nil?
    end
  end

  # Vérifie si une case est occupée. Si elle l'est, renvoie true
  def occupied?(number)
    @cases[number].value != "="
  end

  # change la valeur de la case numéro number
  def change_value(number, char)
    @cases[number].value = char
  end

  # vérifie si trois symboles adjacent sont identiques et pas égale a la valeur d'initialisation des cases
  # Notre case d'initialisation contient un =
  def three_adjacent_symbol?
    if ( (@cases[0].value == @cases[1].value) && (@cases[0].value == @cases[2].value) && (@cases[0].value != "=" )) ||
       ( (@cases[3].value == @cases[4].value) && (@cases[3].value == @cases[5].value) && (@cases[3].value != "=" )) ||
       ( (@cases[6].value == @cases[7].value) && (@cases[6].value == @cases[8].value) && (@cases[6].value != "=" )) ||
       ( (@cases[0].value == @cases[3].value) && (@cases[0].value == @cases[6].value) && (@cases[0].value != "=" )) ||
       ( (@cases[1].value == @cases[4].value) && (@cases[1].value == @cases[7].value) && (@cases[1].value != "=" )) ||
       ( (@cases[2].value == @cases[5].value) && (@cases[2].value == @cases[8].value) && (@cases[2].value != "=" )) ||
       ( (@cases[0].value == @cases[4].value) && (@cases[0].value == @cases[8].value) && (@cases[0].value != "=" )) ||
       ( (@cases[2].value == @cases[4].value) && (@cases[2].value == @cases[6].value) && (@cases[2].value != "=" ))
      true
    else
      false
    end
  end
end

# Chaque case du tableau contient une valeur. On initialise la valeur à "=" pour que les cases ne soient pas vide
class BoardCase
  # chaque case contient une croix ou un rond
  attr_accessor :value

  def initialize
    @value = "="
  end
end

# Chaque joueur a un nom et un symbole (X pour le 1er et O pour le second)
class Players
  # deux joueurs dans la partie
  attr_accessor :name, :symbol, :victory_count
  @@all = 0

  # initialise joueur 1 avec X et joueur 2 avec O
  def initialize(name)
    @name = name
    @symbol = if @@all.even?
                "X"
              else
                "O"
              end
    @@all += 1
    @victory_count = 0
  end
end
