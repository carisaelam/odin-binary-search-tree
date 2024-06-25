# manages sequence of nodes
class LinkedList
  attr_accessor :list, :head

  def initialize
    @head = nil
  end

  # prints whole list as string
  def to_s
    return nil if @head.nil?

    current = @head

    list = []

    size.times do
      list << current.value
      current = current.next_node
      break if current.nil?
    end

    list << 'nil'
    list.join(' -> ')
  end

  # return index of certain value
  def find(value)
    return nil if @head.nil?

    current = @head
    current_index = 0

    loop do
      return current_index if current.value == value

      current = current.next_node
      current_index += 1

      break if current.nil?
    end
  end

  # is value in the list somewhere?
  def contains?(value)
    return nil if @head.nil?

    current = @head
    loop do
      if current.value == value
        return true
        break
      else
        current = current.next_node
        break if current.nil?
      end
    end
    false
  end

  # removes last element from list
  def pop
    return nil if @head.nil?

    current = @head

    loop do
      current = current.next_node
      break if current.next_node == tail
    end
    current.next_node = nil
    p 'pop completed'
    p "removed: #{current}"
  end

  # returns node at given index
  def at(index)
    current_index = 0
    return nil if @head.nil?

    current_node = @head

    loop do
      current_index += 1
      current_node = current_node.next_node
      break if current_index == index
    end
    "current node: #{current_node.value}; next node: #{current_node.next_node.value}"
  end

  # returns last node in the list
  def tail
    return nil if @head.nil?

    current = @head

    loop do
      current = current.next_node
      break if current.next_node.nil?
    end
    current
  end

  # returns first node in the list
  def head
    return nil if @head.nil?

    @head
  end

  # returns number of nodes in list
  def size
    count = 0
    current = @head

    return 0 if current.nil?

    loop do
      current = current.next_node
      count += 1
      break if current.nil?
    end
    count
  end

  # adds new node to start of list
  def prepend(value)
    node = Node.new(value)
    if @head.nil?
      @head = node
    else
      node.next_node = @head
      @head = node
    end
  end

  # adds new node to end of list
  def append(value)
    node = Node.new(value)
    if @head.nil?
      @head = node
    else
      current = @head
      current = current.next_node while current.next_node
      current.next_node = node
    end
  end
end

# represents a single element in the list
class Node
  attr_accessor :value, :next_node

  def initialize(value)
    @value = [value]
    @next_node = nil
  end
end

new_list = LinkedList.new
new_list.append('hi')
# new_list.append('there')
# new_list.append('who')
# new_list.append('are')
# new_list.append('you')
# p new_list.to_s
