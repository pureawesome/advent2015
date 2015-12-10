require 'minitest/autorun'

class One
  def floor(string)
    arr = string.split("")
    neg = arr.find_all {|x| x == ")"}.count
    (arr.count - neg) - neg
  end

  def enter(string)
    arr = string.split("")
    floor = 0
    arr.each_with_index do |item, index|
      item == ")" ? floor -= 1 : floor += 1

      if floor < 0
        return index + 1
      end
    end
  end
end

class TestOne < Minitest::Test
  def setup
    @one = One.new
  end

  def test_one
    assert_equal 3, @one.floor("(()(()(")
  end

  def test_two
    assert_equal -1, @one.floor("))(")
  end

  def test_three
    assert_equal -3, @one.floor(")())())")
  end

  def test_four
    assert_equal 1, @one.enter(")")
  end

  def test_five
    assert_equal 5, @one.enter("()())")
  end
end
