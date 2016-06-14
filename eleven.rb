require 'minitest/autorun'
require 'minitest/pride'

class Eleven
  def initialize
    @number
    @alphabet = ('a'..'z').to_a
    @alphabet_array = @alphabet.map.with_index { |letter, index| [@alphabet[index], @alphabet[index + 1], @alphabet[index + 2]]}.map { |arr| arr.join }.select { |str| str.size == 3 }
  end

  def run(str)
    str.reverse!
    new_password(str)
  end

  def new_password(str)
    not_passing = true

    while not_passing

      zeds = str.match(/(^z+)/).to_a[0]
      new_arr = str.split('')

      unless zeds.nil?
        number = zeds.length + 1
        number.times do |i|
          prev_letter = new_arr[i]
          new_arr[i] = next_letter(prev_letter)
        end
      else
        prev_letter = new_arr[0]
        new_arr[0] = next_letter(prev_letter)
      end

      new_str = new_arr.flat_map{|i| i}.join('')

      if check_reqs(new_str.reverse)
        not_passing = false
        return new_str.reverse
      end

      str = new_str
    end
  end

  def next_letter(letter)
    @alphabet[(@alphabet.index(letter) + 1) % @alphabet.size]
  end

  def check_reqs(str)
    requirement_one(str) && requirement_two(str) && requirement_three(str)
  end

  def requirement_one(str)
    # 3 consecutive letters from alphabet
    (@alphabet_array.size).times do |i|
      @ans = str =~ /#{@alphabet_array[i]}/
      unless @ans.nil?
        break
      end
    end
    return @ans.nil? ? false : true
  end

  def requirement_two(str)
    str.scan(/[i]|[o]|[l]/).count == 0 ? true : false
  end

  def requirement_three(str)
    str.scan(/(.)\1/).count >= 2
  end

end

class TestEleven < Minitest::Test
  def setup
    @eleven = Eleven.new
  end

  def test_one
    # skip
    assert_equal false, @eleven.check_reqs('hijklmmn')
  end

  def test_two
    # skip
    assert_equal true, @eleven.requirement_one('hijklmmn')
  end

  def test_three
    # skip
    assert_equal false, @eleven.check_reqs('abbceffg')
  end

  def test_four
    # skip
    assert_equal true, @eleven.requirement_three('abbceffg')
  end

  def test_seven
    # skip
    assert_equal false, @eleven.requirement_three('abcdefff')
  end

  def test_five
    # skip
    assert_equal 'abcdffaa', @eleven.run('abcdefgh')
  end

  def test_six
    # skip
    assert_equal 'ghjaabcc', @eleven.run('ghijklmn')
  end

  def test_eight
    assert_equal 'abcdffaa', @eleven.run('abcdfezz')
  end

  def test_nine
    assert_equal true, @eleven.requirement_two('abcdffaa')
  end

  def test_ten
    assert_equal true, @eleven.requirement_three('ghjaabcc')
  end
end

@run = Eleven.new
new_pass = @run.run('hepxcrrq')
p new_pass
p @run.run(new_pass)
