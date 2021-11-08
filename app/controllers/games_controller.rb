class GamesController < ApplicationController
  require 'open-uri'
  require 'json'

  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
    is_english = JSON.parse(response.read)['found']
    word_array = params[:word].split('')
    @grid = params[:token].split('')
    @grid.each do |letter|
      word_array.delete(letter.to_str) if word_array.include?(letter)
    end
    if is_english && word_array.empty?
      @message = 'Congrats!'
    elsif is_english && !word_array.empty?
      @message = 'Your word is english but not valid according to your grid...'
    else
      @message = 'Your word is not english...'
    end
  end
end
