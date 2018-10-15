class Board
  #Contient 9 cases
  def initialize 
    @Cases=[]
    9.times do
      @Cases << BoardCase.new
    end
  end

  #Vérifie si la case existe
  def valid? (number)
    !@Cases[number].nil?
  end

  #Vérifie si une case est occupée. Si elle l'est, renvoie true
  def occupied? (number)
    if @Cases[number].value == 0
      false
    else 
      true
    end
  end

  #change la valeur de la case numéro number
  def change_value(number,symbol)
    @Cases[number].value=symbol
  end

  #vérifie si trois symboles adjacent sont identiques et non nuls
  def three_adjacent_symbol?
    tab=@Cases
    if ( (tab[0] == tab [1]) && (tab[0] == tab[2]) && (tab[0] != 0 )) ||
       ( (tab[3] == tab [4]) && (tab[3] == tab[3]) && (tab[3] != 0 )) ||
       ( (tab[6] == tab [7]) && (tab[6] == tab[8]) && (tab[6] != 0 )) ||
       ( (tab[0] == tab [3]) && (tab[0] == tab[6]) && (tab[0] != 0 )) ||
       ( (tab[1] == tab [4]) && (tab[1] == tab[7]) && (tab[1] != 0 )) ||
       ( (tab[2] == tab [5]) && (tab[2] == tab[8]) && (tab[2] != 0 )) ||
       ( (tab[0] == tab [4]) && (tab[0] == tab[8]) && (tab[0] != 0 )) ||
       ( (tab[2] == tab [4]) && (tab[2] == tab[6]) && (tab[2] != 0 )) 
      true
    else 
      false
    end 
  end
end

class BoardCase
  #chaque case contient une croix ou un rond
  attr_accessor :value

  def initialize
    @value=0
  end

end

class Players
  #deux joueurs dans la partie
   attr_accessor :name, :symbol
   @@all = 0
 
  #initialise joueur 1 avec X et joueur 2 avec O
  def initialize (name)
    @name = name
    if @@all == 0
      @symbol = "X"
    else
      @symbol = "O"
    end
    @@all += 1
  end

end