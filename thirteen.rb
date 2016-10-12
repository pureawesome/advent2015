require 'minitest/autorun'
require 'minitest/pride'

file = File.readlines('thirteen.txt')
word_index = [0, 2, 3, 10]
guests = []
combos = {}
totals = []
arr = file.map do |item|
  item.split(' ').select.with_index do |word, index|
    word_index.include?(index) ? word : nil
  end
end
arr.map do |line|
  guests.push(line[0]) unless guests.include?(line[0])
  line[2] = line[2].to_i
  line[2] = -line[2] if line[1] == 'lose'
  line[3] = line[3].delete('.')
  line.delete_at(1)
  keyer = line[0] + line[2]
  value = line[1]
  combos[keyer] = value
end

guests_iters = guests.permutation.to_a

guests_iters.map do |order|
  total = 0
  order.map.with_index do |name, index|
    right = index == order.length - 1 ? name + order[0] : name + order[index + 1]
    left = index == 0 ? name + order[-1] : name + order[index - 1]
    total += combos[left]
    total += combos[right]
  end
  totals.push(total)
end

# p arr
# p guests
# p combos
# p guests_iters
p totals.max
