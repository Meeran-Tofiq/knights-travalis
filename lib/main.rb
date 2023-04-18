class Board
    def initialize
        @layout = Arar.new(8) {Array.new(8) {}}
    end
end

class Knight
    attr_accessor :board, :tree
    def initialize(board)
        @board = board
        @tree = nil
    end

    def build_tree(pos = [0,0], des)
        arr << pos

end
