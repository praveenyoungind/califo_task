require 'json'
class CollegesController < ApplicationController

	def index
		@all = JSON.parse(File.read("#{Rails.public_path}/colleges_list.json"))
		@colleges = Kaminari.paginate_array(@all).page(params[:page]).per(10)
	end

end
