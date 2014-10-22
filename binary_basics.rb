=begin
Binary Basics
Welcome back to another great Monday! Hope every had a great weekend.

As we do from time to time we'll be revisiting one of the basics of computer algorithms. Create a function that takes in a sorted array of integers and a number. The function should then return the index of that number in the array. If the number doesn't exist return -1. If there is a duplicate you can return either position.

Solution
I wanted to attempt this as a binary search.  Turns out returning the error code correctly was the most annoying part.  Also had to be careful on off-by-one issues
=end

def binary_search(a, i)
    # if length is one, we either have the right answer or we don't
    if a.length == 1
        if a[0] == i
            return 0
        else
            return -i+1
        end
    elsif a.length < 1
        return -i
    end
   
    # if the search int is out of bounds, we have the wrong answer
    if a[0] > i or a[a.length-1] < i
        return -1
    end

    # otherwise we compare the middle number and split the array on a mismatch
    mid = (a.length / 2).round
    if a[mid] == i
        return mid
    elsif a[mid] > i
        return binary_search(a[0..mid-1], i)
    else
        return mid+1 + binary_search(a[mid+1..a.length], i)
    end
end
   
x = [1,2,4,6,7,8,9,10]

binary_search(x, 5)
