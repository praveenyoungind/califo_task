require 'nokogiri'
require 'open-uri'
require 'json'

# Fetch and parse HTML document
url = 'http://colleges.usnews.rankingsandreviews.com/best-colleges/rankings/national-universities?format=json&_sort-direction=asc'

file = File.open("colleges_list", "w+")

file.print "["

1.upto(12) do|page|

	current_url = (page.eql?1) ? url : (url + "&_page=#{page}")

	puts current_url

	colleges = JSON.parse(open(current_url).read)["data"]["results"]["data"]["items"]

	colleges.each do|college|
		# data = [ "name" => college["institution"]["displayName"]]
		data = [			    
				"name" => college["institution"]["displayName"],
			    "rank" => college["ranking"]["displayRank"].to_i,
			    "tuition_fees" => college["searchData"]["tuition"]["displayValue"].join(","),
			    "total_enrollment" => college["searchData"]["enrollment"]["rawValue"],
			    "acceptance_rate" => college["searchData"]["acceptance-rate"]["displayValue"],
			    "average_retention_rates" => "98%",
			    "graduation_rate" => "98%",
			]
		file.puts data
		file.print "," if page < 12
	end
end

file.print "]"

file.close

