require 'HTTParty'
require 'Nokogiri'
require 'Pry'
require 'csv'

base_url = "http://ctndisseminationlibrary.org/protocols"
no_of_studies = 60
urls = Array.new(no_of_studies) { |i| "#{base_url}/ctn%04d.htm"%i }

urls.each do |url|
	page = HTTParty.get(url)
	parsed = Nokogiri::HTML(page)

	x = parsed.css("table")
	#If table contains the title "PRELIMINARY RESEARCH FINDINGS", follow the "get article link"

	links = parsed.css("table tr td p a")
	links.each do |link|
		puts "bob"
		puts link
	end
end