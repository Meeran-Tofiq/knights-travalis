class Board
    def initialize
        @layout = Arar.new(8) {Array.new(8)}
    end
end

class Knight
    def initialize(board)
        @board = board
    end
end