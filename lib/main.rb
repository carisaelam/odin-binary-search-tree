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

  def delete(value)
    node_to_delete = find(value)
    p "node_to_delete: #{node_to_delete.data}"
    # start at root, iterate through tree until current.left/right == node_to_delete
    current = @root

    p "we start at the root: #{current.data}"

    # if current is the root
    if current == node_to_delete
      p 'we need to delete the root'

    # if current left is node to delete
    elsif current.left == node_to_delete
      p "you are at the parent node (#{current.data}). node to delete is left child"

      # we need to check for how many children
      p 'checking for children'

      # temp make current.left the main node
      node_to_delete_temp = current.left

      # if there are two children
      if node_to_delete_temp.left && node_to_delete_temp.right
        p "two children: #{node_to_delete_temp.left.data} & #{node_to_delete_temp.right.data}"

      # if only a left child
      elsif node_to_delete_temp.left && !node_to_delete_temp.right
        p "only the left child: #{node_to_delete_temp.right.data}"

      # if that child

      # if only a right child
      elsif !node_to_delete_temp.left && node_to_delete_temp.right
        p "only the right child: #{node_to_delete_temp.right.data}"

      end

      # if current right is node to delete
    elsif current.right == node_to_delete
      p "you are at the parent node (#{current.data}). node to delete is right child"

      # we need to check for how many children
      p 'checking for children'

      # temp make current.right the main node
      node_to_delete_temp = current.right

      # if there are two children
      if node_to_delete_temp.left && node_to_delete_temp.right
        p "two children: #{node_to_delete_temp.left.data} & #{node_to_delete_temp.right.data}"

      # if only a left child
      elsif node_to_delete_temp.left && !node_to_delete_temp.right
        p "only the right child: #{node_to_delete_temp.left.data}"

      # if only a right child
      elsif !node_to_delete_temp.left && node_to_delete_temp.right
        p "only the right child: #{node_to_delete_temp.right.data}"

      end
    end
  end

  # delete main function
  # def delete(value)
  #   @root = delete_node(@root, value)
  # end

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
array = [1, 2, 3, 4, 5, 6, 7, 8, 9]

tree = Tree.new(array)
tree.pretty_print
tree.delete(7)
tree.pretty_print
