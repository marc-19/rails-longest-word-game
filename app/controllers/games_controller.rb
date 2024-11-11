class GamesController < ApplicationController

  require "json"
  require "open-uri"

  def new
    @letters = []
    10.times do
      @letters << ("A".."Z").to_a.sample # to_a returns an array
      # with the elements of the given ranges
    end
    return @letters
  end

  def score
    @attempt = params[:attempt]
    attempt_characters = @attempt.upcase.chars # get a string, return array of characters
    @letters = params[:letters] # thanks to the tag hidden we have put in the form
    # we need to do this otherwise we on't be able to use the @letters generated in the new

    url = "https://dictionary.lewagon.com/#{@attempt.downcase}"
    result_serialized = URI.parse(url).read
    result = JSON.parse(result_serialized)

    @score =
    if attempt_characters.all? { |character| attempt_characters.count(character) > @letters.count(character) }
      "The word is not in the grid"
    elsif result["found"] == false
      "#{@attempt} is not a valid word in English"
    elsif result["found"] == true
      "The word is valid, congrats"
    end
  end
end
