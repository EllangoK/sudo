#require 'rubygems'
require 'net/https'
require 'net/http/persistent'
require 'sparql'
require 'linkeddata'
require 'nokogiri'
#require 'sparql/client'
#require 'rdf/trig'

s = gets
p2 = gets

actualQuery = "SELECT * WHERE { ?" +s " ?" + p2 " ?o }"

queryable = RDF::Repository.load("test.ttl")
solutions = SPARQL.execute(actualQuery, queryable)

#it is easier to convert to an xml and read from instead of directly linking it
#rails

xml_doc  = Nokogiri::XML(solutions.to_json)
puts (xml_doc)
