class Node
    attr_accessor :pos, :next_node, :prev_node
    def initialize(pos, next_node = nil, prev_node = nil)
        @pos = pos
        @next_node = next_node
        @prev_node = prev_node
    end
end

class Board
    attr_accessor :layout
    def initialize
        @layout = Array.new(8) {Array.new(8) { nil }}
    end

    def taken?(pos)
        !layout[pos[0]][pos[1]].nil?
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
end

board = Board.new
p board.taken?([1,5])