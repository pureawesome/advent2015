require 'minitest/autorun'
require 'minitest/pride'

class Reindeer
  def initialize(name, speed, speedtime, rest)
    @name = name
    @speed = speed
    @speedtime = speedtime
    @rest = rest
    @state = 1
  end

  def spot_in_time(time)
    localtime = dist = localcounter = 0
    while localtime <= time
      if @state == 1 && localcounter == @speedtime
        @state = 0
        localcounter = 0
      end

      if @state == 0 && localcounter == @rest
        @state = 1
        localcounter = 0
      end

      dist += @speed if @state == 1
      localcounter += 1
      localtime += 1
    end
    dist
  end
end

reindeers = []

file = File.readlines('fourteen.txt')
file.each do |item|
  line = item.split(' ')
  name = line[0]
  speed = line[3].to_i
  speedtime = line[6].to_i
  rest = line[13].to_i
  name = Reindeer.new(name, speed, speedtime, rest)
  reindeers.push(name)
end

at_time = reindeers.map { |name| name.spot_in_time(2503) }
p at_time.max

class TestFourteen < Minitest::Test
  def setup
    @dancer = Reindeer.new('dancer', 16, 11, 162)
    @comet = Reindeer.new('comet', 14, 10, 127)
  end

  def test_one
    assert_equal 1056, @dancer.spot_in_time(1000)
  end

  def test_two
    assert_equal 1120, @comet.spot_in_time(1000)
  end
end
