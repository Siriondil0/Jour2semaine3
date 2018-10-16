require "./colorization.rb"
require "pry"

# classe du plateau de jeu
class Board
  
  attr_accessor :cases, :game_not_finished

  #Contient 9 cases
  def initialize 
    @cases=[]
    9.times do
      @cases << BoardCase.new
    end
    @game_not_finished = false
  end
  
  # Affiche le tableau. On teste pour chaque case le symbole pour le coloriser de manière appropriée
  def display
    puts "-------------"
    puts "| #{colorize(@cases[0].value)} | #{colorize(@cases[1].value)} | #{colorize(@cases[2].value)} |"
    puts "-------------"
    puts "| #{colorize(@cases[3].value)} | #{colorize(@cases[4].value)} | #{colorize(@cases[5].value)} |"
    puts "-------------"
    puts "| #{colorize(@cases[6].value)} | #{colorize(@cases[7].value)} | #{colorize(@cases[8].value)} |"
    puts "-------------"
  end

  # Colorise la valeur suivant la valeur de la case
  def colorize (val)
    if val == "="
      return val.black
    elsif val == "X"
      return val.blue.bold
    elsif val == "O"
      return val.red.italic
    end
  end

  # Vérifie si la case existe (ie le nombre rentré est entre 0 et 8)
  def valid? (number)
    !@cases[number].nil?
  end

  #Vérifie si une case est occupée. Si elle l'est, renvoie true
  def occupied? (number)
    if @cases[number].value == "="
      false
    else 
      true
    end
  end

  #change la valeur de la case numéro number
  def change_value(number,symbol)
    @cases[number].value=symbol
  end

  #vérifie si trois symboles adjacent sont identiques et non nuls
  def three_adjacent_symbol?
    tab=@cases
    if ( (tab[0].value == tab[1].value) && (tab[0].value == tab[2].value) && (tab[0].value != "=" )) ||
       ( (tab[3].value == tab[4].value) && (tab[3].value == tab[3].value) && (tab[3].value != "=" )) ||
       ( (tab[6].value == tab[7].value) && (tab[6].value == tab[8].value) && (tab[6].value != "=" )) ||
       ( (tab[0].value == tab[3].value) && (tab[0].value == tab[6].value) && (tab[0].value != "=" )) ||
       ( (tab[1].value == tab[4].value) && (tab[1].value == tab[7].value) && (tab[1].value != "=" )) ||
       ( (tab[2].value == tab[5].value) && (tab[2].value == tab[8].value) && (tab[2].value != "=" )) ||
       ( (tab[0].value == tab[4].value) && (tab[0].value == tab[8].value) && (tab[0].value != "=" )) ||
       ( (tab[2].value == tab[4].value) && (tab[2].value == tab[6].value) && (tab[2].value != "=" )) 
      true
    else 
      false
    end 
  end
end


# Chaque case du tableau contient une valeur. On initialise la valeur à "=" pour que les cases ne soient pas vide
class BoardCase
  #chaque case contient une croix ou un rond
  attr_accessor :value

  def initialize
    @value = "="
  end

end

# Chaque joueur a un nom et un symbole (X pour le 1er et O pour le second)
class Players
  #deux joueurs dans la partie
   attr_accessor :name, :symbol, :victory_count
   @@all = 0
 
  #initialise joueur 1 avec X et joueur 2 avec O
  def initialize (name)
    @name = name
    if @@all % 2 == 0
      @symbol = "X"
    else
      @symbol = "O"
    end
    @@all += 1
    @victory_count = 0
  end

end

