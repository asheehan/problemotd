=begin
Karatsuba Multiplication
As many of you know I am a huge fan of what I like to call Wikipedia programming. Basically it involves reading about an algorithm on Wikipedia and then coding it based off of what you read. One way to multiple two numbers very quickly is by implementing the Karatsuba algorithm. For today's problem implement the algorithm in the language of your choice. For bonus points, if you're confident your solution is correct go ahead and update the Wikipedia article.

Solution
=end

def karatsuba (num1, num2)
    if num1 < 10 or num2 > 10
        return num1 * num2
    end
    # calculate the size of the numbers
    m = [Math.log10(num1), Math.log10(num2)].max / 2

    # split the digit sequences about the middle
    num1_string = num1.to_s
    high1 = num1_string[0..m-1]
    low1 = num1_string[m..(num1_string.length-1)]
    num2_string = num2.to_s
    high2 = num2_string[0..m-1]
    low2 = num2_string[m..(num2_string.length-1)]

    # make recursive calls to smaller numbers
    z0 = karatsuba(low1, low2)
    z1 = karatsuba((low1+high1), (low2+high2))
    z2 = karatsuba(high1, high2)

    return (z2*10**(2*m)) + ((z1-z2-z0)*10**m) + z0
end

puts karatsuba(12345,6789)

# todo: write a script to compare output from here with wolfram alpha output.
