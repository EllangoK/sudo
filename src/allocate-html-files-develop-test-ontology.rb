require 'ap'
require 'fileutils'
require 'json'

record = {"testing" => [], "training" => []}

Dir.glob("./data/pages-as-html/*") do |file|
	unless File.directory? file
		if rand > 0.7
			record["testing"] << File.basename(file) 
			FileUtils.cp(file,"./data/testing/"+File.basename(file))
		else
			record["training"] << File.basename(file)
			FileUtils.cp(file,"./data/training/"+File.basename(file))
		end
	end
end

File.open('./data/testing-training-allocation.json','w') do |f|
	f.write(record.to_json)
end