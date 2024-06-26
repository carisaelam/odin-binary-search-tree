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
    p 'find method begins...'
    # p "current: #{current.data}"
    # p "value: #{value}"
    if !@array.include?(value)
      p 'value not in array'
      nil
    elsif current.data == value
      p "we found it: #{current}"
      current
    elsif value < current.data
      find(value, current.left)
    elsif value > current.data
      find(value, current.right)
    end
  end

  # traverse tree and performe delete
  def delete_node(node, value)
    p "i am the delete node function, and i am trying to delete #{value}"
    p "current node = #{node.data}"

    return nil if node.nil?

    p "current before recursion: #{node.data}"

    if node.data == value
      p "i have found the data to be deleted: #{node.data}"

      # leaf node = return nil
      if !node.left && !node.right
        p '🍀 leaf node'
        return nil

      # single child = return child
      elsif node.left && !node.right
        return node.left
      elsif !node.left && node.right
        return node.right
      end

    # two children
    ## find smallest value on right tree or largest on left

    ## replace value of node to be deleted with value of successor or predecessor

    ## recursively call delete_node to delete the successor or predecessor, which is now a duplicate

    elsif node.data < value
      node.right = delete_node(node.right, value)
    else
      node.data > value
      node.left = delete_node(node.left, value)
    end

    p "current after recursion: #{node.data}"
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

    # p "sorted arr: #{arr}"
    # p "start: #{start}"
    # p "ending: #{ending}"
    if start > ending
      nil
    else
      mid = ((start + ending) / 2).floor
      # p "midpoint of array = #{arr[mid]}"

      node = Node.new(arr[mid])
      node.left = build_tree(arr, start, mid - 1)
      node.right = build_tree(arr, mid + 1, ending)
      # p "➡️ here's the node....#{node}"
      # p "node left #{node.left}"
      # p "node right #{node.right}"
      node
    end
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

  # pretty print method from discord
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

# array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
array = [1, 2, 3, 4]

tree = Tree.new(array)
tree.pretty_print
tree.delete(4)
tree.pretty_print
