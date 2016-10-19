# easy1_hex.rb
# 0-9, ABCDEF

class Hex

  def initialize(string)
    @num_array = string
  end

  def to_decimal
    return 0 if @num_array.match(/[^0-8a-fA-f]/)
    @num_array = to_digits(@num_array)
    @num_array.reverse.map.with_index{ |n, index| n*16**(index)}.reduce(&:+)
  end

  def to_digits(arr)
    arr.chars.map do |n|
      case n.downcase
      when 'a' then 10
      when 'b' then 11
      when 'c' then 12
      when 'd' then 13
      when 'e' then 14
      when 'f' then 15
      else n.to_i
      end
    end
  end

end

# p Hex.new('xxxxx').to_decimal
p Hex.new('1234').to_decimal
p Hex.new('AB').to_decimal
p Hex.new('ab').to_decimal