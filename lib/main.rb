class Node
    attr_accessor :pos, :next_node, :prev_node
    def initialize(pos, next_node = nil, prev_node = nil)
        @pos = pos
        @next_node = next_node
        @prev_node = prev_node
    end
end

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
