require 'minitest/autorun'
require 'minitest/pride'

require 'digest'

class Four
  def getHash(str)
    count = 0
    md5 = Digest::MD5.new
    md5.hexdigest

    while (count)
      md5.reset
      md5.update "#{str}#{count}"
      break if md5.to_s.slice(0, 6) == '000000'
      count += 1
    end
    count
  end
end

class TestFour < Minitest::Test
  def setup
    @four = Four.new
  end

  def test_one
    # skip
    assert_equal 609043, @four.getHash("abcdef")
  end

  def test_two
    # skip
    assert_equal 1048970, @four.getHash("pqrstuv")
  end
end

@run = Four.new
p @run.getHash("ckczppom")
