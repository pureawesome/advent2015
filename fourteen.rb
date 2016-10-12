require 'minitest/autorun'
require 'minitest/pride'

class Reindeer
  def initialize(name, speed, speedtime, rest)
    @name = name
    @speed = speed
    @speedtime = speedtime
    @rest = rest
    @state = 0
  end

  def spot_in_time(time)
    bulk_jumps = 1
    dist = 0
    while bulk_jumps == 1
      if @state == 0 && time > @speedtime
        dist += @speed * @speedtime
        time -= @speedtime
        @state = 1
      elsif @state == 1 && time > @rest
        time -= @rest
        @state = 0
      else
        dist += @speed * time if @state == 0
        bulk_jumps = 0
      end
    end
    @state = 0
    dist
  end
end

def points(time, items)
  points = items.map { 0 }
  time.times do |index|
    disters = items.map { |item| item.spot_in_time(index + 1) }
    disters.each.with_index { |num, spot| points[spot] += 1 if num == disters.max }
  end
  points
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
p 'question one is ' + at_time.max.to_s
p points(2503, reindeers).max

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

  def test_three
    assert_equal [689, 312], points(1000, [@dancer, @comet])
  end
end
