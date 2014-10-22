=begin
Large Primes
Welcome back from another kick ass weekend!

Today's problem digs in to the one of the key factors of cryptology, generating large, random, prime numbers. Today's exercise is to create a program that prints out all prime numbers that can fit in a 32 bit unsigned int.

Solution
=end

require 'prime'

max = 2**32
Prime.each(max) do |prime|
  puts prime
end
