=begin
Six Times
There exists at least one number that is 6 times the sum of its digits. What is the first occurrence of this phenomenon and are there any other numbers with this same pattern? For bonus points write a program to solve this problem.

Solution
=end

upperBound = ARGV[0].to_i
for i in 0..upperBound
    digits = i.to_s.chars.map(&:to_i)
    sum = 0
    digits.each do |digit|
        sum += digit
    end
   
    if i == (sum * 6)
        puts i
    end
end

# output: 0, 54
