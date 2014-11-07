=begin

3s A Sum
Given an array of integers find the largest consecutive sum of 3 integers. In the array [1,5,8,3,2,7,4], the largest sum of 3 consecutive is 5+8+3. When you find the largest sum print out the 3 integers. Can you solve this in O(n)?

=end

# traverse input array saving the sum of that variable and the next 2 in a new array if it's larger than the old maximum value
def max_sum(input)
  max = 0
  max_index = 0
  input.each_with_index do |x, i|
    if i > (input.length - 3)
      break
    end
    current_value = [x, input[i+1], input[i+2]].inject(0, &:+)
    if current_value > max
      max = current_value
      max_index = i
    end
  end
  return input.slice((max_index), 3)
end

input = [1,5,8,4,9,7,4]
p max_sum(input)
