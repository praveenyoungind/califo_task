def make_flat(array)
  # write your code here
	flat = []
	array.each do|element|
		if element.class == Array
			flat.push(make_flat(element))
		else
			flat.push(element)
		end
	end
	flat.join(", ")
end

puts make_flat([1, 2, 3, [4, 6, [7, 8]], 5, 9, 10])

# output : 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
