require 'open-uri'
require 'json'

namespace :college_scraper do

  desc "Get the list of colleges from the respective site and put in file"

  task get_list: :environment do

		url = 'http://colleges.usnews.rankingsandreviews.com/best-colleges/rankings/national-universities?format=json&_sort-direction=asc'

		file = File.open("#{Rails.public_path}/colleges_list.json", "w+")

		file.print "["

		1.upto(12) do|page|

			current_url = (page.eql?1) ? url : (url + "&_page=#{page}")

			puts current_url

			get_colleges_and_save(file, current_url, page)
		end

		file.print " {} ]"

		file.close

  end

end

def get_colleges_and_save(file, current_url, page)
		colleges = JSON.parse(open(current_url).read)["data"]["results"]["data"]["items"]

		colleges.each do|college|
			# data = [ "name" => college["institution"]["displayName"]]
			data = [			    
					name: college["institution"]["displayName"],
				    rank: college["ranking"]["sortRank"],
				    tuition_fees: college["searchData"]["tuition"]["displayValue"].join(","),
				    total_enrollment: college["searchData"]["enrollment"]["rawValue"],
				    acceptance_rate: college["searchData"]["acceptance-rate"]["displayValue"],
				    average_retention_rates: "98%",
				    graduation_rate: "98%",
				].to_json.chop
			data[0] = ""
			file.puts data + ","
		end
end