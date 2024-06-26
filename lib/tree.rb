require_relative 'linked_list'

class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  attr_accessor :root

  def initialize(array)
    @array = array.sort.uniq
    @root = build_tree(@array)
  end

  # finds and returns a given value recursively
  def find(value, current = @root)
    if current.data == value
      current
    elsif value < current.data
      find(value, current.left)
    elsif value > current.data
      find(value, current.right)
    end
  end

  # helper function for delete method
  def find_successor(current)
    return current if current.left.nil?

    current = find_successor(current.right)
  end

  def delete_node(node, value)
    return nil if node.nil?

    # finding the node to delete
    if node.data == value

      # leaf node = return nil
      return nil if !node.left && !node.right

      # single child = return child
      if node.left && !node.right
        return node.left
      elsif !node.left && node.right
        return node.right
      end

      # two children ==>

      ## find smallest value on right tree or largest on left
      successor = find_successor(node)

      # copies successor value to node to be deleted
      node.data = successor.data

      ## recursively call delete_node to delete the successor or predecessor, which is now a duplicate
      node.right = delete_node(node.right, successor.data)

    elsif node.data < value
      node.right = delete_node(node.right, value)

    else

      node.left = delete_node(node.left, value)

    end
    node
  end

  # delete main function
  def delete(value)
    delete_node(@root, value)
  end

  def build_tree(array, start = 0, ending = nil)
    arr = array.sort.uniq
    length = arr.length
    ending = ending.nil? ? (length - 1) : ending

    if start > ending
      nil
    else
      mid = ((start + ending) / 2).floor

      node = Node.new(arr[mid])
      node.left = build_tree(arr, start, mid - 1)
      node.right = build_tree(arr, mid + 1, ending)

      node
    end
    node
  end

  # recursive method for navigating through tree and inserting new node
  def insert_recurse(node, value)
    return Node.new(value) if node.nil?

    if value < node.data
      node.left = insert_recurse(node.left, value)
    elsif value > node.data
      node.right = insert_recurse(node.right, value)
    end

    node
  end

  # insert a node at the correct spot in the tree
  def insert(value)
    @root = insert_recurse(@root, value)
  end

  def level_order
    return if @root.nil?

    queue = []
    level_order_traversal = []
    queue.push(@root)

    until queue.empty?
      current = queue.shift
      level_order_traversal.push(current.data)

      yield(current) if block_given?

      queue.push(current.left) if current.left
      queue.push(current.right) if current.right
    end

    level_order_traversal
  end

  def pre_order(node = @root, pre_order_traversal = [])
    return if node.nil?

    yield(node) if block_given?
    pre_order_traversal.push(node.data)
    pre_order(node.left, pre_order_traversal)
    pre_order(node.right, pre_order_traversal)

    p "PRE_ORDER TRAVERSAL = #{pre_order_traversal}" if node == @root
  end

  def in_order(node = @root, in_order_traversal = [])
    return if node.nil?

    yield(node) if block_given?
    in_order(node.left, in_order_traversal)
    in_order_traversal.push(node.data)
    in_order(node.right, in_order_traversal)

    p "IN_ORDER TRAVERSAL = #{in_order_traversal}" if node == @root
  end

  def post_order(node = @root, post_order_traversal = [])
    return if node.nil?

    yield(node) if block_given?
    post_order(node.left, post_order_traversal)
    post_order(node.right, post_order_traversal)
    post_order_traversal.push(node.data)

    p "POST_ORDER TRAVERSAL = #{post_order_traversal}" if node == @root
  end

  def height(node = @root)
    return 0 if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    current_height = 1 + [left_height, right_height].max

    current_height - 1 if node == @root
    current_height
  end

  def depth(node = @root, current = @root, current_depth = 0)
    # if node is root, depth is 0
    return -1 if current.nil?

    return current_depth if current == node

    # otherwise, calculate depth
    left_depth = depth(node, current.left, current_depth + 1)
    right_depth = depth(node, current.right, current_depth + 1)

    if left_depth != -1
      left_depth
    elsif right_depth != -1
      right_depth
    else
      -1
    end
  end

  def find_leaf(current = @root)
    leaves = []

    if current.left.nil? && current.right.nil?
      leaves.push(current)
      return leaves
    end

    leaves.concat(find_leaf(current.left)) if current.left

    leaves.concat(find_leaf(current.right)) if current.right

    leaves
  end

  def balanced?(node = @root)
    return true if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    balance_condition = (left_height - right_height).abs <= 1
    return false unless balance_condition

    balanced?(node.left) && balanced?(node.right)
  end

  def rebalance
    # traverse tree to get array
    traversal = level_order
    @root = build_tree(traversal)
  end

  # pretty print method from discord
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

# array = [1, 3, 4, 5, 7, 8, 9, 23, 67, 324, 6345, 6400, 6401, 6402]

# array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
# # array = [1, 2, 3]
# tree = Tree.new(array)
# node_ex = tree.find(1)
# tree.insert(6400)
# tree.insert(6401)
# tree.insert(6402)
# tree.pretty_print
# tree.rebalance
# tree.pretty_print
