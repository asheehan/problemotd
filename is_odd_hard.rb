=begin

Today's challenge is a new take on a classic. Without using the modulus operator or converting the number to binary to check the least significant bit, can you write a function to determine if an integer is prime or not?

=end

def is_odd(x)
    y = ((x - 1) / 2).floor
    x = (x / 2).floor
    return (x == y)
end

def is_whole(x)
    return (x == x.floor and x == x.ceil)
end

def is_prime(x)
    if is_odd(x)
        n = (x / 2).floor
        if !is_odd(n)
            n -= 1
        end
        while n > 1 do
            if is_whole(x.to_f / n)
                return false
            end
            n -= 2
        end
        return true
    end
    return false
end

p is_prime(37)
