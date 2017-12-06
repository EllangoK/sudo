require 'HTTParty'
require 'Nokogiri'
require 'json'
require 'ap'

test_case = "./pages-as-html/ctn0001"

#Would be more elegant to use a schema. 
#This is more transparent.

Dir.foreach('./data/pages-as-html/') do |file|
	unless file.start_with?(".") or File.directory? file
		doc_as_html = File.open("./data/pages-as-html/"+file){|f| Nokogiri::HTML(f)}
		doc_as_html.css('script').remove
		doc_as_html.css('td[class=yellow]').remove

		tables = doc_as_html.css('table')
		content = doc_as_html.css('table table')[0].css("tr td").text.split("\r\n\r\n\r\n")[3]
		doc_as_xml = Nokogiri::XML::Builder.new do |xml|
		 	xml.Project {
				Title = tables[0].css('p[class=medheaderblue]').text.split.join(" ")
				xml.ProjectTitle Title

				inner_tables = tables.css('table')[1].css('p[class=smalltext]')
				citation = inner_tables[0]
				authors = inner_tables[1]
				further_citation = inner_tables[2]
				xml.ProjectDescription {
					xml.ToEdit content
				}
				xml.AuthorSet {
					xml.Author {
						authors.text.split('),').each do |author|
							author_degree,affiliation = author.split(' (')
							author, degree = author_degree.split(',',2)
							xml.Name author.strip()
							xml.AffiliationSet { 
								xml.Project.AuthorSet.Author.Affiliation affiliation
							}
							xml.DegreeSet {
								unless degree.nil?
									degrees = degree.split(',')
									if degrees.instance_of? String
										xml.Degree degrees
									elsif degrees.instance_of? Array
										degrees.each do |degree|
											xml.Degree degree
										end 
									end
								end
							}
						end					
						}
					}
				}
		end
		File.write("./data/pages-as-xml/",doc_as_xml.toxml)
	end
end
