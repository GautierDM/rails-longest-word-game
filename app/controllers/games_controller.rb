require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.shuffle[0..10]
  end

  def score
    @answer = params[:word]
    @letters = params[:letters]
    @letters_string = @letters.gsub(' ', ', ')
    if  !include?(@answer)
      @rep = "Sorry but #{@answer} cannot be built out of #{@letters_string} "
    elsif english_word?(@answer)
      @rep = "Congratulation #{@answer} is a valid English word and your score is #{@answer.length} "
    else
      @rep = "Sorry but #{@answer} is not a valid english word"
    end
  end


  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def include?(answer)
    answer.chars.all? { |letter| @answer.count(letter) <= @letters.count(letter) }
  end


  # def compute_score(attempt, time_taken)
  #   time_taken > 60.0 ? 0 : attempt.size * (1.0 - time_taken / 60.0)
  # end

end
