require 'pry-byebug'

class Node
    attr_accessor :pos, :next_nodes, :prev_node
    def initialize(pos, next_nodes = [], prev_node = nil)
        @pos = pos
        @next_nodes = next_nodes
        @prev_node = prev_node
    end

    def print_route
        node = self
        str = "#{node.pos}"
        until node.prev_node.nil?
            node = node.prev_node
            str = "#{node.pos} => " + str
        end
        str
    end
end

class Board
    attr_accessor :layout
    def initialize
        @layout = Array.new(8) {Array.new(8) { nil }}
    end

    def set_position(pos)
        return if taken?(pos) || !within_board_range?(pos)
        layout[pos[0]][pos[1]] = "K"
    end

    def taken?(pos)
        return false if layout[pos[0]].nil?
        !layout[pos[0]][pos[1]].nil?
    end

    def within_board_range?(pos)
        pos[0] < 8 && pos[1] < 8 && pos[0] >= 0 && pos[1] >= 0
    end

    def reset
        @layout = Array.new(8) {Array.new(8) { nil }}
    end

    def print_layout
        layout.each { |line| p line}
    end
end

class Knight
    TRANSFORMATIONS = [[-1, -2], [-2, -1], [-1, 2], [2, -1], [1, -2], [-2, 1], [1, 2], [2, 1]].freeze

    attr_accessor :board, :pos
    def initialize(pos = [0, 0], board = Board.new)
        @pos = pos
        @board = board
    end

    def build_routes(pos = @pos, des)
        return nil unless board.within_board_range?(des)
        
        pos_node = Node.new(pos)
        p pos_node
        queue = [pos_node]
        puts queue

        queue.each do |current_pos|
            TRANSFORMATIONS.each do |t|
                new_pos = [current_pos.pos[0] + t[0], current_pos.pos[1] + t[1]]

                next if board.taken?(new_pos) || !board.within_board_range?(new_pos)

                board.set_position(current_pos.pos)

                new_node = Node.new(new_pos)
                new_node.prev_node = current_pos
                current_pos.next_nodes << new_node

                puts new_node
                if new_pos == des
                    board.print_layout
                    board.reset
                    return new_node 
                end
                queue << new_node
            end
        end
    end
end

knight = Knight.new([0,1])
p knight.build_routes([0, 0]).print_route
p knight.build_routes([0,0]).print_route
