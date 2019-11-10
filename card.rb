class Card

attr_accessor :value, :face_down

def initialize(value)
    @face_down = true
    @value = value 
end 

def hide
    @face_down = true
end

def reveal
    @face_down = false
end

def to_s
    if @face_down 
        return " "
    else
        return @value
    end
end

def ==(other_card)
    self.value == other_card.value
end

end