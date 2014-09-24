# find the top 3 integers in an unsorted array in linear time
unsorted_array = 100.times.map{ Random.rand(100) }
top_array = [0, 0, 0]
unsorted_array.each do |x|
  for y in 0..2 do
    if top_array[y] < x
      top_array[y] = x
      top_array.sort!
      break
    end
  end
end
puts top_array
