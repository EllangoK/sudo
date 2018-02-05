require 'csv'
require 'awesome_print'
require 'json'

folder = "../data/training/"
header = ["Filename","Mike","Karun"]

r = Random.new

filename = "../data/chary-karun-split.csv"
#format that clinical trial reporting may like

arr = {"Mike"=>[], "Karun" =>[]}

CSV.open(filename,'wb') do |csv|
	csv << header
	Dir.glob("../data/training/*.{xml}") do |file|

		#Manuscripts like CSV
		rnum = r.rand(2)
		file = File.basename(file)
		line = if rnum then [file,1,0] else [file,0,1] end
		csv << line 

		 #JSON is easier on the eyes. 
		if rnum == 0
			arr["Mike"] << file
		else
			arr["Karun"] << file
		end
	end
end

File.open('../data/chary-karun-split.json','wb') do |f|
	f.write(arr.to_json)
end