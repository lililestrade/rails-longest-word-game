require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @answer = params['word']
    @grid = params['grid'].chars
    if included?(@answer.upcase, @grid)
      if english_word?(@answer)
        @result = 'Well done!'
      else
        @result = 'Not an english word!'
      end
    else
      @result = 'All the letters are not in the grid!'
    end
  end

  private

  def included?(answer, grid)
    answer.chars.all? do |letter|
      answer.count(letter) <= grid.count(letter)
    end
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
