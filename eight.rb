require 'minitest/autorun'
require 'minitest/pride'

class Eight
  def initialize
    @code = 0
    @memory = 0
    @encode = 0
  end

  def reset
    @code = 0
    @memory = 0
    @encode = 0
  end

  def dif(str)
    @code += str.length
    @memory += eval(str).length
  end

  def encode(str)
    @code += str.length
    @encode += str.inspect.length
  end

  def run(str = nil)
    if str.nil?
      IO.readlines('./eight.txt').map(&:chomp).each { |line| dif(line) }
    else
      dif(str)
    end
    totalDif(@code, @memory)
  end

  def rerun(str = nil)
    if str.nil?
      IO.readlines('./eight.txt').map(&:chomp).each { |line| encode(line) }
    else
      encode(str)
    end
    totalDif(@encode, @code)
  end

  def totalDif(c,d)
    c - d
  end
end

class TestEight < Minitest::Test
  def setup
    @eight = Eight.new
  end

  def test_three
    # skip
    @eight.reset
    assert_equal 3, @eight.run('"aaa\"aaa"')
  end

  def test_one
    @eight.reset
    assert_equal 2, @eight.run('""')
  end

  def test_two
    @eight.reset
    assert_equal 2, @eight.run('"abc"')
  end

  def test_four
    # skip
    @eight.reset
    assert_equal 5, @eight.run('"\x27"')
  end

  def test_five
    # skip
    @eight.reset
    assert_equal 4, @eight.rerun('""')
  end

  def test_six
    # skip
    @eight.reset
    assert_equal 4, @eight.rerun('"abc"')
  end

  def test_seven
    # skip
    @eight.reset
    assert_equal 6, @eight.rerun('"aaa\"aaa"')
  end

  def test_eight
    # skip
    @eight.reset
    assert_equal 5, @eight.rerun('"\x27"')
  end
end

@run = Eight.new
p @run.rerun
