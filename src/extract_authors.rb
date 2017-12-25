require 'Nokogiri'
require 'ap'

placeholder = "placeholder"
sample_file =  "../data/training/ctn0001"

Dir.glob('../data/training/*') do |filename|
	begin 
		file = File.read(filename)
		ap filename
		doc = Nokogiri::XML(file)


		doc.css('script').remove
		doc.css('td[class=yellow]').remove

		tables = doc.css('table')
		content = []

		#ap tables.css('table')
		paragraphs = tables[2].css('p')

		paragraphs.each do |paragraph|
			unless paragraph.text.gsub(/\A[[:space:]]+|[[:space:]]+\z/, '').empty?
				content << paragraph.text.gsub(/\A[[:space:]]+|[[:space:]]+\z/, '').split.join(" ")
			end
		end

		#Authors are in block 4
		project_title = content[1]
		citation = content[2]
		authors = content[3].split("), ")
		abstract_text = content[4]
		conclusion = content[5]
		keywords = content[6].split("Document No")[0].gsub("Keywords: ","").split(" | ")

		b = Nokogiri::XML::Builder.new do |xml|
		  xml.send(:Project){
		  	xml.send(:ProjectTitle,project_title)
		  	xml.send(:CitationSet){
		  		xml.send(:Citation,citation)
		  	}
			  xml.send(:AuthorSet) {
					authors.each do |author|
						person, institution = author.split('(')
						name_degrees = person.split(', ')
						name = name_degrees.shift.strip()
						xml.send(:Name,name)
						xml.send(:DegreeSet){
							name_degrees.each do |degree|
								degree = degree.strip()
								xml.send(:Degree,degree)
							end
						}
						xml.send(:AffiliationSet){
							xml.send(:Affiliation,institution)
						}
					end
				}
			xml.send(:ProjectDescription){
				xml.send(:Abstract){
					xml.send(:AbstractText,abstract_text)
					xml.send(:PopulationSpecification){
						xml.send(:Enrollment){
							xml.send(:CriterionSet){
								xml.send(:Criterion){
									xml.send(:CriterionType,placeholder)
									xml.send(:CriterionSpecification,placeholder)
								}
							}
						}
						xml.send(:Allocation){
							xml.send(:AllocationPredicate){
								xml.send(:AllocationPredicateFunction){
									xml.send(:AllocationPredicateFunctionSignature,placeholder)
									xml.send(:AllocationPredicateFunctionArgumentSet){
										xml.send(:AllocationPredicateFunctionArgument){
											xml.send(:AllocationPredicateFunctionArgumentName,placeholder)
											xml.send(:AllocationPredicateFunctionArgumentValue,placeholder)
										}
									}
								}
							}
						}
						xml.send(:AllocatedStudyArmSet){
							xml.send(:AllocatedStudyArm){
								xml.send(:Name,placeholder)
								xml.send(:InitialSize){
									xml.send(:SubgroupSet){
										xml.send(:Subgroup){
											xml.send(:Name,placeholder)
											xml.send(:Size,placeholder)
										}
									}
								}
								xml.send(:InterventionSet){
									xml.send(:Intervention,placeholder)
								}
								xml.send(:MetricResultSet){
									xml.send(:MetricResult)
								}
							}
						}
						xml.send(:PlannedActionSet){
							xml.send(:PlannedAction){
								xml.send(:Name,placeholder)
								xml.send(:IntendedTargetPopulation,placeholder)
								xml.send(:PlannedActionSpecification){
									xml.send(:TypeOfAction,placeholder)
									xml.send(:TypeSpecificFields)
								}
							}
						}
						xml.send(:MetricSpecificationSet){
							xml.send(:MetricSpecification){
								xml.send(:Name,placeholder)
								xml.send(:Measurement){
									xml.send(:MeasurementName,placeholder)
									xml.send(:MeasurementUnits,placeholder)
								}
							xml.send(:IntendedTargetPopulationSet){
								xml.send(:IntendedTargetPopulation){
									xml.send(:Name,placeholder)
									xml.send(:Value,placeholder)
								}
							}
							xml.send(:StatisticSpecification){
								xml.send(:StatisticName,placeholder)
								xml.send(:ModifierSet){
									xml.send(:Modifier,placeholder)
								}
								xml.send(:FalsePositiveChance,0.05)
							}
							}
						}
						xml.send(:MetricResultSet){
							xml.send(:MetricResult){
								xml.send(:MetricName,placeholder)
								xml.send(:AllocatedStudyArmSet){
									xml.send(:AllocatedStudyArm){
										xml.send(:Name,placeholder)
										xml.send(:MetricValue,placeholder)
									}
								}
							}
						}
					}
					xml.send(:Conclusion,conclusion)
					xml.send(:KeywordSet){
						keywords.each do |keyword|
							xml.send(:Keyword,keyword)
						end
					}
				}
				}
			}
		end
		new_filename = filename + '_template.xml'
		File.write(new_filename,b.to_xml)
	rescue
		ap filename
	end
end