# https://www.codewars.com/kata/521c2db8ddc89b9b7a0000c1/train/ruby
# Given an n x n array, return the array elements arranged from outermost elements to the middle element, traveling clockwise.

# array = [[1,2,3],
#          [4,5,6],
#          [7,8,9]]
# snail(array) #=> [1,2,3,6,9,8,7,4,5]
# For better understanding, please follow the numbers of the next array consecutively:

# array = [[1,2,3],
#          [8,9,4],
#          [7,6,5]]
# snail(array) #=> [1,2,3,4,5,6,7,8,9]

# NOTE: The idea is not sort the elements from the lowest value to the highest; the idea is to traverse the 2-d array in a clockwise snailshell pattern.

# NOTE 2: The 0x0 (empty matrix) is represented as en empty array inside an array [[]].

# Very clever ass solution: 
# def snail(array)
#   array.empty? ? [] : array.shift + snail(array.transpose.reverse)
# end

def move(dir, travel, coord, arr, snail)
  inc = (dir == 'n' || dir == 'w') ? -1 : 1
  cur = (dir == 'n' || dir == 's') ? coord[0] : coord[1]
  spot = (dir == 'n' || dir == 'w') ? cur - travel : cur + travel
  until cur == spot
    cur += inc
    (dir == 'n' || dir == 's') ? snail.push(arr[cur][coord[1]]) : snail.push(arr[coord[0]][cur])
  end
  coord = (dir == 'n' || dir == 's') ? [coord[0]+(inc*travel), coord[1]] : [coord[0], coord[1]+(inc*travel)]
  return [coord, snail]
end

def snail(array) 
  return [] if array[0].empty?

  travel = array.length - 1
  # initiate traversal of grid
  snail = [array[0][0]]
  coord = [0,0]
  coord, snail = move('e', travel, coord, array, snail)
  
  # repeating logic
  until travel.zero?
    coord, snail = move('s', travel, coord, array, snail)
    coord, snail = move('w', travel, coord, array, snail)
    travel -= 1
    break if travel.zero?
    coord, snail = move('n', travel, coord, array, snail)
    coord, snail = move('e', travel, coord, array, snail)
    travel -= 1
  end
  return snail
end

# snail([[1,2,3], [4,5,6], [7,8,9]])
p snail([[]])
p snail([[1,2,3,4,5], [6,7,8,9,10], [11,12,13,14,15], [16,17,18,19,20], [21,22,23,24,25]])
