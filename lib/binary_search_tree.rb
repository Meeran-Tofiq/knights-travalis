require 'pry-byebug'

class Node
    include Comparable

    attr_accessor :data, :left, :right
    def initialize(data=nil)
        @data = data
        @left = nil
        @right = nil
    end
    
    def has_children?
        !(left.nil? && right.nil?)
    end
    
    def has_one_child?
        left.nil? ^ right.nil?
    end  

    def has_two_children?
        !left.nil? && !right.nil?
    end
    
    def child
        if has_one_child?
            return (left.nil? ? right : left)
        end
    end

    def <(other)
        self.data < (other.is_a?(Node) ? other.data : other)
    end

    def >(other)
        self.data > (other.is_a?(Node) ? other.data : other)
    end

    def <=(other)
        self.data <= (other.is_a?(Node) ? other.data : other)
    end

    def >=(other)
        self.data >= (other.is_a?(Node) ? other.data : other)
    end

    def ==(other)
        return false if other == nil
        self.data == (other.is_a?(Node) ? other.data : other)
    end

    def to_s
        str = "\nNode: \n\tdata = #{data}"
        str.concat("\tleft = #{left.data}") unless left.nil?
        str.concat("\tright = #{right.data}") unless right.nil?
        str
    end
end

class Tree
    attr_accessor :root
    def initialize(arr)
        @dataset = arr.sort.uniq
        @root = build_tree(@dataset)
    end

    def build_tree(arr)
        return nil if arr.empty?

        mid = (arr.size - 1)/2
        
        current_root = Node.new(arr[mid])
        current_root.left = build_tree(arr[0...mid])
        current_root.right = build_tree(arr[(mid+1)..-1])

        current_root
    end

    def insert(value, node = root)
        return nil if value == node.data
    
        if value < node.data
          node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
        else
          node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
        end
    end

    def delete(val)
        temp = root
        parent = nil

        until temp == val
            parent = temp
            temp = (temp > val ? temp.left : temp.right)
            return if temp == nil
        end

        if temp.has_children?
            replace_with_next_biggest(temp)
        else
            parent.left == val ? parent.left = nil : parent.right = nil
        end
    end

    def find(val, node = root)
        return node if node == val || node.nil?

        node > val ? find(val, node.left) : find(val, node.right)
    end

    def replace_with_next_biggest(node)
        next_biggest = node.right

        until next_biggest.left.nil?
            next_biggest = next_biggest.left
            puts next_biggest.data
        end

        data = next_biggest.data
        delete(next_biggest.data)
        node.data = data
    end

    def level_order
        arr = [root]
        res = []

        until arr.empty?
            current_node = arr.shift
            res << current_node
            arr << current_node.left unless current_node.left.nil?
            arr << current_node.right unless current_node.right.nil?
        end

        block_given? ? res.each { |node| yield node } : res.map(&:data)
    end 

    def preorder(node = root, arr = [])
        arr << node
        preorder(node.left, arr) unless node.left.nil?
        preorder(node.right, arr) unless node.right.nil?
        
        block_given? ? res.each { |node| yield node } : res.map(&:data)
    end

    def inorder(node = root, arr = [])
        inorder(node.left, arr) unless node.left.nil?
        arr << node
        inorder(node.right, arr) unless node.right.nil?
        
        block_given? ? res.each { |node| yield node } : res.map(&:data)
    end

    def postorder(node = root, arr = [])
        postorder(node.left, arr) unless node.left.nil?
        postorder(node.right, arr) unless node.right.nil?
        arr << node
        
        block_given? ? res.each { |node| yield node } : res.map(&:data)
    end

    def height(node)
        if node.nil?
            return 1
        else
            left_height = (node.left.nil? ? 0 : 1 + height(node.left))
            right_height = (node.right.nil? ? 0 : 1 + height(node.right))
            [left_height, right_height].max
        end
    end

    def depth(node, current_node = root)
        if node == current_node
            return 0
        else
            1 + (node > current_node ? depth(node, current_node.right) : depth(node, current_node.left))
        end
    end
    
    def balanced?(node = root)
        if node.has_two_children?
            return balanced?(node.left) && balanced?(node.right) && ((height(node.left) - height(node.right)).abs() <= 1)
        elsif node.has_one_child?
            return !node.child.has_children?
        else
            return true
        end
    end

    def rebalance
        @root = build_tree(inorder)
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end
end
