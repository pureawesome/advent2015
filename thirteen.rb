require 'minitest/autorun'
require 'minitest/pride'

file = File.readlines('thirteen_test.txt')
guests = []
combos = {}
totals = []

file.each do |item|
  line = item.delete('.').split(' ')
  names = line[0] + line[10]
  diff = line[2] == 'lose' ? -line[3].to_i : line[3].to_i
  combos[names] = diff
  guests.push(line[0]) unless guests.include?(line[0])
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

p totals.max
