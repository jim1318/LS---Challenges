# palindrome

# no regex
# no reverse

VALID = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)

def palindrome(input)
  letters = input.downcase.chars.select { |letter| VALID.include?(letter) }
  (letters.length / 2).times do 
    return false if letters.shift != letters.pop
  end
  return true
end

p palindrome("abdog123") == false
p palindrome("mom") == true
p palindrome("mmaasaamm") == true
p palindrome("") == true