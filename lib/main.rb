require_relative 'tree'

# [x] Create a binary search tree from an array of random numbers (Array.new(15) { rand(1..100) })
array = Array.new(15) { rand(1..100) }
tree = Tree.new(array)
tree.pretty_print

# output =>
# │           ┌── 96
# │       ┌── 95
# │       │   └── 80
# │   ┌── 71
# │   │   │   ┌── 66
# │   │   └── 57
# │   │       └── 55
# └── 53
#     │       ┌── 49
#     │   ┌── 26
#     │   │   └── 25
#     └── 18
#         │   ┌── 11
#         └── 7

# [x] Confirm that the tree is balanced by calling #balanced?
p tree.balanced?
# output => true

# [ ] Print out all elements in level, pre, post, and in order
p tree.level_order
# output => [42, 24, 80, 14, 29, 63, 84, 9, 23, 27, 33, 50, 76, 82, 87]

p tree.pre_order
# output => [42, 24, 14, 9, 23, 29, 27, 33, 80, 63, 50, 76, 84, 82, 87]

p tree.in_order
# output => [9, 14, 23, 24, 27, 29, 33, 42, 50, 63, 76, 80, 82, 84, 87]

p tree.post_order
# output => [9, 23, 14, 27, 33, 29, 24, 50, 76, 63, 82, 87, 84, 80, 42]

# [x] Unbalance the tree by adding several numbers > 100
tree.insert(102)
tree.insert(150)
tree.insert(199)
tree.insert(300_000)
tree.pretty_print
# output =>
# │                           ┌── 300000
# │                       ┌── 199
# │                   ┌── 150
# │               ┌── 102
# │           ┌── 96
# │       ┌── 95
# │       │   └── 80
# │   ┌── 71
# │   │   │   ┌── 66
# │   │   └── 57
# │   │       └── 55
# └── 53
#     │       ┌── 49
#     │   ┌── 26
#     │   │   └── 25
#     └── 18
#         │   ┌── 11
#         └── 7

# [x] Confirm that the tree is unbalanced by calling #balanced?
p tree.balanced?
# output => false

# [x] Balance the tree by calling #rebalance
tree.rebalance
tree.pretty_print

# output =>
# │               ┌── 300000
# │           ┌── 199
# │       ┌── 150
# │       │   └── 102
# │   ┌── 98
# │   │   │       ┌── 85
# │   │   │   ┌── 73
# │   │   └── 71
# │   │       └── 66
# └── 55
#     │           ┌── 48
#     │       ┌── 42
#     │   ┌── 30
#     │   │   └── 25
#     └── 20
#         │   ┌── 13
#         └── 10
#             └── 6

# [x] Confirm that the tree is balanced by calling #balanced?
p tree.balanced?
# output => true

# [x] Print out all elements in level, pre, post, and in order.
p tree.level_order
# output => [56, 41, 99, 8, 48, 66, 150, 3, 22, 45, 53, 57, 79, 102, 199, 55, 85, 300000]

p tree.pre_order
# output => [63, 19, 8, 6, 14, 37, 25, 40, 48, 97, 76, 66, 78, 82, 150, 102, 199, 300000]

p tree.in_order
# output => [6, 8, 14, 19, 25, 37, 40, 48, 63, 66, 76, 78, 82, 97, 102, 150, 199, 300000]

p tree.post_order
# output => [6, 14, 8, 25, 48, 40, 37, 19, 66, 82, 78, 76, 102, 300000, 199, 150, 97, 63]
