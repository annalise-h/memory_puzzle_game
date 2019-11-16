require_relative 'board.rb'
require_relative 'card.rb'

class Game

    attr_accessor :board, :previous_guess

    def initialize
        @board = Board.new
        @previous_guess = ""
    end

    def play 
        @board.populate

        puts self.board.grid

        until @board.won?
            self.make_guess
        end

        system("clear")
        puts "Congratulations! You win."
    end

    def make_guess

        if @previous_guess.empty? 
            @board.render
            self.make_first_guess
        else
            @board.render
            self.make_second_guess
        end
    end

    def make_first_guess
        puts "Please enter the position of the card you'd like to flip (e.g. '2,3')" 
        guess = gets.chomp

        if !self.valid?(guess)
            puts "Oops! That's not a valid guess. Try again"
            return self.make_first_guess
        end

        @previous_guess = guess
        @board.reveal(guess)
    end

    def make_second_guess
        puts "Enter your second guess. Previous guess = '#{@previous_guess}'"
        second_guess = gets.chomp

        if !self.valid?(second_guess)
            puts "Oops! That's not a valid guess. Try again"
            return self.make_second_guess
        end

        if @board[@previous_guess] == @board[second_guess]
            @board.reveal(second_guess)
            puts "You got a match!"
            @previous_guess = ""
        else
            @board.reveal(second_guess)
            puts "Oops, not a match! Try again"
            @board[@previous_guess].hide
            @board[second_guess].hide
            sleep(2)
            @previous_guess = ""
        end
    end

    def valid?(guess)
        letters = [*"a".."z",*"A".."Z"]
        valid_numbers = [*"0".."3"]   

        return false if guess.length != 3 || guess == @previous_guess 

        guess_array = guess.split(",")

        guess_array.each do |ele|
            if letters.include?(ele) || !valid_numbers.include?(ele)
                return false
            end
        end

        return false if board[guess].face_down == false

        true
    end

end

game = Game.new
game.play