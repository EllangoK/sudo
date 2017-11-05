require 'HTTParty'
require 'Nokogiri'
require 'Pry'
require 'csv'

base_url = 'http://ctndisseminationlibrary.org/protocols/'
no_of_studies = 60
urls = Array.new(no_of_studies) { |i| "http://ctndisseminationlibrary.org/protocols/%04d.htm"%i }

urls.each do |url|
	page = HTTParty.get(url)
	parsed = Nokogiri::HTML(page)

	puts parsed
end