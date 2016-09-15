require 'minitest/autorun'
require 'minitest/pride'

file = File.readlines('thirteen.txt')
word_index = [0, 2, 3, 10]
arr = file.map do |item|
  item.split(' ').select.with_index do |word, index|
    word_index.include?(index) ? word : nil
  end
end

p arr
