module AreAnagrams
    def self.are_anagrams?(string_a, string_b)
	if(string_a.split("").sort  == string_b.split("").sort)
		return 'anagram'
	else
		return 'not anagram'
	end
       # raise NotImplementedError, "Not implemented"
    end
end


puts "The words momdad dadmom are " + AreAnagrams.are_anagrams?('momdad', 'dadmom')
