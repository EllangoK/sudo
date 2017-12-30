require 'Nokogiri'

class ClinicalTrial #Represent Trial as an Object

  def initialize(file_location)
    @file_location = file_location
    @doc = File.open(@file_location) { |f| Nokogiri::XML(f) }
  end

  def gather_pop
    pop_count = string_to_noise(@doc.css('Count').first.to_s.match(/>(.*)</))
    pop_specification = string_to_noise(@doc.css('CriterionSpecification').first.to_s.match(/>(.*)</))
    pop_something = string_to_noise(@doc.css('AllocationPartitionStudyPopulationOption').first.to_s.match(/>(.*)</))
    return [pop_count, pop_specification, pop_something]
  end

  def gather_actions
    action_treatment = string_to_noise(@doc.css('Intervention').first.to_s.match(/>(.*)</))
    action_drug = string_to_noise(@doc.css('InterventionType').first.to_s.match(/>(.*)</))
    return [action_treatment, action_drug]
  end

  def gather_measurements
    measure_name = string_to_noise(@doc.css('MeasurementName').first.to_s.match(/>(.*)</))
    measure_unit = string_to_noise(@doc.css('MeasurementUnits').first.to_s.match(/>(.*)</))
    return [measure_name, measure_unit]
  end
end

def compareToOtherTrial(trial, trial_two)
  if trial.gather_pop[0] == trial_two.gather_pop[0]
    puts 'pop_count'
    return true
  elsif trial.gather_pop[1] == trial_two.gather_pop[1]
    puts 'pop_specification'
    return true
  elsif trial.gather_pop[2] == trial_two.gather_pop[2]
    puts 'pop_something'
    return true
  elsif trial.gather_actions[0] == trial_two.gather_actions[0]
    puts 'actions'
    return true
  elsif trial.gather_actions[1] == trial_two.gather_actions[1]
    puts 'actions'
    return true
  elsif trial.gather_measurements[0] == trial_two.gather_measurements[0]
    puts 'measure_name'
    return true
  elsif trial.gather_measurements[1] == trial_two.gather_measurements[1]
    puts 'measure_unit'
    return true
  else
    return false
  end
end

def string_to_noise(str) #Filters Out Empty Data via Noise
  if (str.to_s.empty?)
    return rand(100000).to_s
  else
    return str
  end
end

trial_one = ClinicalTrial.new('../data/training/ctn0005.xml')
trial_two = ClinicalTrial.new('../data/training/finished/ctn0001.xml')
puts compareToOtherTrial(trial_one, trial_two)