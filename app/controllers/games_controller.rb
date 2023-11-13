require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @letters = params[:letters]
    @user_input = params[:user_input]

    url = "https://wagon-dictionary.herokuapp.com/#{@user_input}"
    response = URI.open(url)
    json = JSON.parse(response.read)

    # Does the user input fit into the letters of the grid?
    if @user_input.chars.all?{ |letter| @user_input.count(letter) <= @letters.count(letter)}
      if json["found"] # Found in dictonary
        @result = "Congrats, your word #{@user_input} is within #{@letters} and great!!! 🪩"
      else
        @result = "Hmmmm nope, not in the dictonary 📖"
      end
    else
      @result = "WSWWWRONGGGG"
    end
  end
end
