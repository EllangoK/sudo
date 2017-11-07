require 'HTTParty'
require 'Nokogiri'
require 'json'
require 'ap'

base_url = "http://ctndisseminationlibrary.org/protocols"
no_of_studies = 60

db = JSON.parse(File.read("./db.json"))

no_of_studies.times do |i|

	url = "%s/ctn%04d.htm"%[base_url,i]
	page = Nokogiri::HTML(HTTParty.get(url))

	links = page.css("table tr td p a")
	links.each do |link|
		if link.text == "get article"
			link_to_article  = link["href"]
			primary_research = Nokogiri::HTML(HTTParty.get(link_to_article))

			filename = "./pages/ctn%04d"%[i]
			File.write(filename,primary_research)
		end
	end
end