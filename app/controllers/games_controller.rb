require 'open-uri'

class GamesController < ApplicationController
  def new
    alphabet = ('A'..'Z').to_a
    @letters = []
    while @letters.size < 10
      @letters << alphabet.sample
      alphabet -= @letters
    end
  end

  def score
    @letters = params[:letters]
    @word = params[:word]
    @valid = valid?(@word, @letters)
    @word_is_english = word_is_english(@word)
    # raise
  end

  def valid?(attempt, grid)
    attempt.chars.each do |char|
      counter = attempt.count(char)
      counter_grid = grid.count(char.upcase)
      return false if counter > counter_grid
    end
    return true
  end

  def word_is_english(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    word_english = JSON.parse(URI.open(url).read)
    return {
      found: word_english["found"],
      length: word_english["length"],
      word: word_english["word"]
    }
  end
end
