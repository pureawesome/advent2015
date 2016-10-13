containers = File.readlines('seventeen.txt').map(&:to_i)

combos_container = []
lengths_container = []

containers.count.times do |index|
  combos = containers
            .combination(index).to_a
            .delete_if { |array| array.inject(:+) != 150 }

  # part 2
  lengths = combos.map do |line|
    if line.count == 1
      line.each {|combo| p combo }
    else
      line.count
    end
  end

  lengths_container.push(lengths)
  combos_container.push(combos)
end
# part 1
p combos_container.flatten(1).count
# part 2
p lengths_container.reject(&:empty?)[0].count
