require 'ap'

template = File.open('../data/template.xml'){|f| f.read()}

Dir.glob('../data/training/*') do |file|
	new_filename = file + '.xml'
	File.open(new_filename,'w'){|f| f.write(template)}
end
