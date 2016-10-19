#easy1_fizz

#Print numbers 1 to 100
# For multiples of 3 print Fizz
# For multiples of 5 print Buzz
# For multiples of 3 and 5 print FizzBuzz

class FixxBuzz

  def initialize
    @numbers = (1..100).to_a
  end

  def execute
    result = @numbers.map do |num|
      case 
      when (num % 5 == 0) && (num % 3 == 0) then "FizzBuzz"
      when (num % 5 == 0) then "Buzz"
      when (num % 3 == 0) then "Fizz"
      else num
      end
    end
    puts result.join(' ')
  end

end



test = FixxBuzz.new
test.execute