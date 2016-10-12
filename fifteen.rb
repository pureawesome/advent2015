@total = 100

def get_splits(total, count)
  combos_all = (0...total).to_a.combination(count).to_a
                          .delete_if { |array| array.inject(:+) != total }
                          .map { |set| set.permutation.to_a }
                          .flatten(1)
  combos_all
end

def get_total (ingredients)
  totals = []
  splits = get_splits(100, ingredients.count)
  splits.each do |split|
    total = { capacity: 0, durability: 0, flavor: 0, texture: 0, calories: 0 }
    ingredients.each.with_index do |ingred, index|
      ingred.each do |key, value|
        # part 1
        # total[key] += value * split[index] unless key == 'calories'.to_sym
        # part 2
        total[key] += value * split[index]
      end
    end
    # part 2
    if total[:calories] == 500
      total[:calories] = 1
      split_total = total.values.map { |num| num < 0 ? 0 : num }.inject(:*)
      totals.push(split_total)
    else
      next
    end
  end
  totals.max
end

ingredients_test = [
  { capacity: -1, durability: -2, flavor: 6, texture: 3, calories: 8 },
  { capacity: 2, durability: 3, flavor: -2, texture: -1, calories: 3 }
]

# p get_total(ingredients_test)

ingredient_list = File.readlines('fifteen.txt').map do |line|
  arr = line.split(/[:|,|\n]/).map(&:strip)
  arr.shift
  hash = {}
  arr.each do |pair|
    split = pair.split(' ')
    hash[split[0].to_sym] = split[1].to_i
  end
  hash
end

p get_total(ingredient_list)
