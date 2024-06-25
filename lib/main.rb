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
    @start = 0
    @ending = @array.length - 1
    @root = build_tree(@array, @start, @ending)
  end

  def build_tree(array, start, ending)
    arr = array.sort.uniq
    length = arr.length

    p "sorted arr: #{arr}"
    p "start: #{start}"
    p "ending: #{ending}"
    if start > ending
      nil
    else
      mid = ((start + ending) / 2).floor
      p "midpoint of array = #{arr[mid]}"

      node = Node.new(arr[mid])
      node.left = build_tree(arr, start, mid - 1)
      node.right = build_tree(arr, mid + 1, ending)
      p "➡️ here's the node....#{node}"
      p "node left #{node.left}"
      p "node right #{node.right}"
      node
    end
  end

  # pretty print method from discord
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

# array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
array = [1, 2, 3, 4, 5, 6, 7].sort.uniq

new_tree = Tree.new(array).pretty_print
# [ ] Write a #build_tree method which takes an array of data (e.g., [1, 7, 4, 23, 8,
#     9, 4, 3, 5, 7, 9, 67, 6345, 324]) and turns it into a balanced binary tree full of Node objects appropriately placed (don’t forget to sort and remove duplicates!). The #build_tree method should return the level 0 root node.

#     def build_tree(arr, start, end)
#       arr = arr.sort.uniq
#       if start > end return null
#       else
#         mid = (start + end) / 2
#         node = Node.new(arr[mid])
#         node.left = build_tree(arr, start, mid-1)
#         node.right = build_tree(arr, mid+1, end)
#       return node
#     end

#       Pretty Print method
#
