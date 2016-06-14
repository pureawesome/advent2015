require 'minitest/autorun'
require 'minitest/pride'

class Ten
  def initialize
    @number
  end

  def run(iterations, number)
    @number = number.to_s.split('').map(&:to_i)
    (iterations).times do
      arr = @number
      @number = arr.slice_when { |before, after| before != after }.flat_map  { |number| [number.count, number.first] }
    end

    @number.join('').length
  end
end

class TestTen < Minitest::Test
  def setup
    @ten = Ten.new
  end

  def test_one
    # skip
    assert_equal 6, @ten.run(5, 1)
  end

end

@data = 3113322113

@run = Ten.new
p @run.run(40, @data)
p @run.run(50, @data)
