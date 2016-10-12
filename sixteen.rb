require 'json'
sues = File.readlines('sixteen.txt').map do |line|
  arr = line.split(/[:|,|\n]/).map(&:strip)
  name = arr.shift
  hash = {}
  hash[arr[0].to_sym] = arr[1].to_i
  hash[arr[2].to_sym] = arr[3].to_i
  hash[arr[4].to_sym] = arr[5].to_i
  { name => hash }
end

# p sues

data = {
  children: 3,
  cats: 7,
  samoyeds: 2,
  pomeranians: 3,
  akitas: 0,
  vizslas: 0,
  goldfish: 5,
  trees: 3,
  cars: 2,
  perfumes: 1
}


matches = data.map do |key, value|
  sues.map { |sue| sue.keys if sue.values[0][key] == value }.compact.flatten
end

p matches.flatten.group_by(&:itself).values.max_by(&:size).first
