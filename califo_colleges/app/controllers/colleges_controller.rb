require 'json'
class CollegesController < ApplicationController

	def index
		@colleges = JSON.parse(File.read("#{Rails.public_path}/colleges_list.json"))
	end

end
