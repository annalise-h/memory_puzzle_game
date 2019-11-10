require_relative 'card.rb'

class Board

attr_accessor :grid

def initialize
    @grid = Array.new(4) { Array.new(4) } 
end

def get_card_pairs
    cards = []
    possible_cards = [*'A'...'Z']

    until cards.length == 16  
        card = possible_cards.sample
        2.times do 
            cards << card
        end
        possible_cards.delete(card)
    end

    cards
end

def populate
    shuffled_cards = self.get_card_pairs.shuffle

    @grid.each do |subgrid|
        subgrid.map! { |card| card = Card.new(shuffled_cards.pop) }
    end

    @grid
end

def render
    system("clear")

    coordinates = [" ","0","1","2","3"]

    puts coordinates.join(" ")

    @grid.each_with_index do |subgrid, idx|
        rows = subgrid.each { |card| card.to_s }
        puts "#{idx}" + " " + rows.join(" ")
    end
end

def won?
    all_cards = @grid.flatten

    if all_cards.any? { |card| card.face_down == true} 
        return false
    end

    true
end

def reveal(guessed_pos)
    self[guessed_pos].reveal
    self.render
end

def [](pos)
    coordinates = pos.split(",")
    x, y = coordinates[0].to_i, coordinates[1].to_i
    @grid[x][y]
end

end