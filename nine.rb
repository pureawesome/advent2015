require 'minitest/autorun'
require 'minitest/pride'

class Nine
  def initialize
    @hash = {}
    @cities = []
    @flight_plans = []
    @shortest_route = 1000000000
    @longest_route = 0
  end

  def reset
  end

  def create_hash(str)
    arr = str.gsub(/\s+/, '').split("=")
    cities = arr[0].split('to')

    #add routes as key value pairs
    @hash[arr[0]] = arr[1].to_i
    @hash[cities[1] + 'to' + cities[0]] = arr[1].to_i

    # add cities if not in array
    @cities.push(cities[0]) unless @cities.include? cities[0]
    @cities.push(cities[1]) unless @cities.include? cities[1]
  end

  def create_plans
    @flight_plans = @cities.permutation.to_a
  end

  def run_plans
    @flight_plans.each do |plan|
      length = 0
      for i in (0...plan.length - 1)
        leg_key = plan[i] + 'to' + plan[i + 1]
        length += @hash[leg_key]
      end
      check_length(length)

    end
  end

  def check_length(number)
    @shortest_route = @shortest_route > number ? number : @shortest_route
    @longest_route = @longest_route < number ? number : @longest_route
  end

  def run(data)
    # IO.readlines('./eight.txt').map(&:chomp).each { |line| dif(line) }
    data.split("\n").each { |line| create_hash(line) }
    create_plans

    run_plans
    @shortest_route
    @longest_route
  end
end

class TestNine < Minitest::Test
  def setup
    @nine = Nine.new
  end

  def test_one
    skip
    @eight.reset
    assert_equal 2, @eight.run('""')
  end

end

@data = %q(Tristram to AlphaCentauri = 34
Tristram to Snowdin = 100
Tristram to Tambi = 63
Tristram to Faerun = 108
Tristram to Norrath = 111
Tristram to Straylight = 89
Tristram to Arbre = 132
AlphaCentauri to Snowdin = 4
AlphaCentauri to Tambi = 79
AlphaCentauri to Faerun = 44
AlphaCentauri to Norrath = 147
AlphaCentauri to Straylight = 133
AlphaCentauri to Arbre = 74
Snowdin to Tambi = 105
Snowdin to Faerun = 95
Snowdin to Norrath = 48
Snowdin to Straylight = 88
Snowdin to Arbre = 7
Tambi to Faerun = 68
Tambi to Norrath = 134
Tambi to Straylight = 107
Tambi to Arbre = 40
Faerun to Norrath = 11
Faerun to Straylight = 66
Faerun to Arbre = 144
Norrath to Straylight = 115
Norrath to Arbre = 135
Straylight to Arbre = 127)

@run = Nine.new
p @run.run(@data)
