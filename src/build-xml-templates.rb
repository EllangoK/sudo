require 'HTTParty'
require 'Nokogiri'
require 'json'
require 'ap'

test_case = "./pages-as-html/ctn0001"

#Would be more elegant to use a schema. 
#This is more transparent.

doc_as_html = File.open(test_case){|f| Nokogiri::HTML(f)}
doc_as_xml = Nokogiri::XML::Builder.new do |xml|

	Title = doc_as_html.css("title").text.split.join(" ")
	xml.send(:ProjectTitle, Title)


	Table = doc_as_html.css("table table p")
	ap Table
end

ap doc_as_xml.to_xml

#Extract Title