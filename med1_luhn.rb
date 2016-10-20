# lunh algorithm challenge

class Luhn
  TRANSFORM     = [0, 2, 4, 6, 8, 1, 3, 5, 7, 9]

  attr_reader :number

  def initialize(number)
    @number = format_input(number)
  end

  def addends
    @number.reverse.map.with_index { |digit, index| index.even? ? digit : TRANSFORM[digit]}.reverse
  end

  def checksum
    addends.inject(&:+)
  end

  def valid?
    checksum % 10 == 0
  end

  def self.make_good(number)
    luhn = Luhn.new(number * 10)
    return 0 if luhn.valid?
    10 - (luhn.checksum % 10)
  end

  def self.create(number)
    luhn = Luhn.new(number)
    return number if luhn.valid?
    (number * 10) + make_good(number)
  end

  private

  def format_input(number)
    number.to_s.chars.map(&:to_i)
  end
end


require 'minitest/autorun'

class LuhnTest < Minitest::Test
  def test_addends
    luhn = Luhn.new(12_121)
    assert_equal [1, 4, 1, 4, 1], luhn.addends
  end

  def test_too_large_addend
    luhn = Luhn.new(8631)
    assert_equal [7, 6, 6, 1], luhn.addends
  end

  def test_checksum
    luhn = Luhn.new(4913)
    assert_equal 22, luhn.checksum
  end

  def test_checksum_again
    luhn = Luhn.new(201_773)
    assert_equal 21, luhn.checksum
  end

  def test_invalid_number
    luhn = Luhn.new(738)
    refute luhn.valid?
  end

  def test_valid_number
    luhn = Luhn.new(8_739_567)
    assert luhn.valid?
  end

  def test_create_valid_number
    number = Luhn.create(123)
    assert_equal 1230, number
  end

  def test_create_other_valid_number
    number = Luhn.create(873_956)
    assert_equal 8_739_567, number
  end

  def test_create_yet_another_valid_number
    number = Luhn.create(837_263_756)
    assert_equal 8_372_637_564, number
  end
end

# Tests

p Luhn.create(837_263_756)
p Luhn.new(Luhn.create(837_263_756)).valid?
p Luhn.new(738).valid? == false
p Luhn.new(1111).valid? == false
p Luhn.new(8763).valid? == true
p Luhn.new(2323200577663554).valid? == true
p Luhn.new(8_739_567).valid? == true
p Luhn.new(201_773).checksum == 21
p Luhn.new(4913).checksum == 22



