=begin

3s A Sum
Given an array of integers find the largest consecutive sum of 3 integers. In the array [1,5,8,3,2,7,4], the largest sum of 3 consecutive is 5+8+3. When you find the largest sum print out the 3 integers. Can you solve this in O(n)?

=end

def max_sum(input)
    threes = Array.new
    input.each_with_index { |x, i|
        if i > (input.length - 3)
            break
        end
        threes << [x, input[i+1], input[i+2]].inject(0, &:+)
    }
    p input.slice(threes.index(threes.max), 3)
end

input = [1,5,8,4,2,7,4]
max_sum(input)
