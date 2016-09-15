require 'minitest/autorun'
require 'minitest/pride'
require 'json'

class Twelve
  def initialize
  end

  def run(str)
    @total = 0
    iterate(str)
    # str.scan(/[-]?\d+/).to_a.map(&:to_i).reduce(&:+)
  end

  def run2(str)
    @total = 0
    iterate2(str)
    p @total

    # my_var = JSON.parse(str)#.flatten.map(&:to_i).reduce(&:+)
    # iterate2(my_hash)
  end

  def iterate(item)
    item.each do |item|
      if item.is_a?(itemay)
        iterate(item)
      elsif item.is_a?(Hash)
        item.each do |k, v|
          if v.is_a?(itemay) || v.is_a?(Hash)
            iterate(v)
          elsif v.is_a?(Fixnum)
            @total += v
          # else
          #   p v
          end
        end
      elsif item.is_a?(Fixnum)
        @total += item
      # else
      #   p item
      end
    end
    @total
  end

  def iterate2(item)
    if item.is_a?(Fixnum)
      @total += item
    elsif item.is_a?(Array)
      item.each do |i|
        if i.is_a?(Fixnum)
          @total += i
        else
          iterate2(i)
        end
      end
    elsif item.is_a?(Hash)
      return 0 if item.value?('red')
      item.each do |k, v|
        if v.is_a?(Fixnum)
          @total += v
        else
          iterate2(v)
        end
      end
    else
      return 0
    end
  end

end

class TestTwelve < Minitest::Test
  def setup
    @twelve = Twelve.new
  end

  def test_one
    # skip
    assert_equal 4, @twelve.run2([1,{"c":"red","b":2},3])
  end

  def test_two
    # skip
    assert_equal 0, @twelve.run2([{"d":"red","e":[1,2,3,4],"f":5}])
  end

  def test_three
    assert_equal 6, @twelve.run2([1,2,3])
  end

  def test_four
    assert_equal 6, @twelve.run2([1,"red",5])
  end
end

file = File.read('twelve.json')
@run = Twelve.new
my_var = JSON.parse(file)
# p @run.run(my_var)
@run.run2(my_var)
