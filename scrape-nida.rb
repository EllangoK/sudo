require 'HTTParty'
require 'Nokogiri'
require 'json'
require 'ap'

base_url = "http://ctndisseminationlibrary.org/protocols"
no_of_studies = 60
urls = Array.new(no_of_studies) { |i| "#{base_url}/ctn%04d.htm"%i }

db = JSON.parse(File.read("./db.json"))

urls.each do |url|
	page = Nokogiri::HTML(HTTParty.get(url))

	links = page.css("table tr td p a")
	links.each do |link|
		if link.text == "get article"
			link_to_article  = link["href"]
			primary_research = Nokogiri::HTML(HTTParty.get(link_to_article))
			
			ap primary_research.css('p .text a')
			#Fields to get, link to article
			db << {"url" => link_to_article,
					"title" => primary_research.css(".medheaderblue").text.split.join(' '),
					"text" => "",
					"keywords" =>""}
		end
	end
end

ap db 