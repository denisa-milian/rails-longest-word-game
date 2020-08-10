require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('a'..'z').to_a.sample }
  end

  def score
    @score = 0
    @word = params[:word].downcase
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    result = JSON.parse(open(url).read)
    @word = @word.split('')
    if result['found'] && @word.all? { |char| @word.count(char) <= params[:letters].downcase.count(char) }
      @message = 'Well done!'
      @score = @word.size * 3
    else
      @message = 'Not an english word'
      @message = 'Not in the grid' if result['found']
      @score
    end

    if session[:score]
      session[:score] += @score
    else
      session[:score] = @score
    end
  end
  # the session function is already build in the RAILS
end
