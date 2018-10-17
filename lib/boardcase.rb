# frozen_string_literal: true

require 'bundler'
Bundler.require
require "pry"

# Chaque case du tableau contient une valeur. On initialise la valeur à "=" pour que les cases ne soient pas vide
class BoardCase
  # chaque case contient une croix ou un rond
  attr_accessor :value

  def initialize
    @value = "="
  end
end
