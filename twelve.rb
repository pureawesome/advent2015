require 'minitest/autorun'
require 'minitest/pride'
require 'json'

class Twelve
  def initialize
  end

  def run(str)
    str.scan(/[-]?\d+/).to_a.map(&:to_i).reduce(&:+)
  end
end

class TestTwelve < Minitest::Test
  def setup
    @twelve = Twelve.new
  end

  def test_one
    skip
    assert_equal false, @eleven.check_reqs('hijklmmn')
  end
end

file = File.read('twelve.json')
@run = Twelve.new
p @run.run(file)
