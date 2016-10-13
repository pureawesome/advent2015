containers = File.readlines('seventeen.txt').map(&:to_i)

combos_container = []

containers.count.times do |index|
  combos = containers
            .combination(index).to_a
            .delete_if { |array| array.inject(:+) != 150 }
  combos_container.push(combos)
end
p combos_container.flatten(1).count
