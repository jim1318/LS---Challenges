# easy1_trinary.rb

#Trinary numbers can only contain three symbols: 0, 1, and 2.
#Invalid trinary entries should convert to decimal number 0.

class Trinary

  def initialize(num_string)
    @num_array = num_string
  end

  def to_decimal
    return 0 if @num_array.match(/[^0-2]/)
    @num_array = @num_array.chars.map(&:to_i)
    @num_array.reverse.map.with_index{ |n, index| n*3**(index)}.reduce(&:+)
  end

end

require 'minitest/autorun'

class TrinaryTest < Minitest::Test
  def test_trinary_1_is_decimal_1
    assert_equal 1, Trinary.new('1').to_decimal
  end

  def test_trinary_2_is_decimal_2
    assert_equal 2, Trinary.new('2').to_decimal
  end

  def test_trinary_10_is_decimal_3
    assert_equal 3, Trinary.new('10').to_decimal
  end

  def test_trinary_11_is_decimal_4
    assert_equal 4, Trinary.new('11').to_decimal
  end

  def test_trinary_100_is_decimal_9
    assert_equal 9, Trinary.new('100').to_decimal
  end

  def test_trinary_112_is_decimal_14
    assert_equal 14, Trinary.new('112').to_decimal
  end

  def test_trinary_222_is_26
    assert_equal 26, Trinary.new('222').to_decimal
  end

  def test_trinary_1122000120_is_32091
    assert_equal 32_091, Trinary.new('1122000120').to_decimal
  end

  def test_invalid_trinary_is_decimal_
    assert_equal 0, Trinary.new('carrot').to_decimal
  end

  def test_invalid_trinary_with_digits_is_decimal_0
    assert_equal 0, Trinary.new('0a1b2c').to_decimal
  end
end