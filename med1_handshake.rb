# med1_handshake.rb


class SecretHandshake
  SECRET = ["wink", "double blink", "close your eyes", "jump", true]

  def initialize(commands)
    @commands = prepare(commands)
  end

  def commands
    handshake = @commands.map.with_index { |n, i| n = SECRET[i] if n == '1' }
    handshake.reverse!.shift if handshake[4] == true
    handshake.compact
  end

  def prepare(commands)
    # What about if length is too long??
    return commands.to_s(2).chars.reverse if commands.class == Fixnum
    return commands.chars.reverse if commands.chars.all? { |char| char =~ /[0-1]/ } 
    []
  end

end

p SecretHandshake.new(1).commands
p SecretHandshake.new(2).commands
p SecretHandshake.new(4).commands
p SecretHandshake.new(8).commands

require 'minitest/autorun'

class SecretHandshakeTest < Minitest::Test
  def test_handshake_1_to_wink
    handshake = SecretHandshake.new(1)
    assert_equal ['wink'], handshake.commands
  end

  def test_handshake_10_to_double_blink
    handshake = SecretHandshake.new(2)
    assert_equal ['double blink'], handshake.commands
  end

  def test_handshake_100_to_close_your_eyes
    handshake = SecretHandshake.new(4)
    assert_equal ['close your eyes'], handshake.commands
  end

  def test_handshake_1000_to_jump
    handshake = SecretHandshake.new(8)
    assert_equal ['jump'], handshake.commands
  end

  def test_handshake_11_to_wink_and_double_blink
    handshake = SecretHandshake.new(3)
    assert_equal ['wink', 'double blink'], handshake.commands
  end

  def test_handshake_10011_to_double_blink_and_wink
    handshake = SecretHandshake.new(19)
    assert_equal ['double blink', 'wink'], handshake.commands
  end

  def test_handshake_11111_to_double_blink_and_wink
    handshake = SecretHandshake.new(31)
    expected = ['jump', 'close your eyes', 'double blink', 'wink']
    assert_equal expected, handshake.commands
  end

  def test_valid_string_input
    handshake = SecretHandshake.new('1')
    assert_equal ['wink'], handshake.commands
  end

  def test_invalid_handshake
    handshake = SecretHandshake.new('piggies')
    assert_equal [], handshake.commands
  end
end