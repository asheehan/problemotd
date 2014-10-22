=begin
Palindrome
Hope everyone is coming back from a great weekend!

We've done some stuff with palindromes before but let's change it up one more time. This time around we're going to create a function that takes in a string and determines if a string is a palindrome or not.

Solution
Lots of different ways to do this, this might be one of the simpler/shorter
=end

# return true if the input string is a palindrome
def isPalindrome(input)
    return input == input.reverse
end
