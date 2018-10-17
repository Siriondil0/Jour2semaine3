# frozen_string_literal: true

require 'bundler'
Bundler.require
require "pry"

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
