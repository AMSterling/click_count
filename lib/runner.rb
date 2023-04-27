require './lib/data_structure'
require './lib/click'

filename = './data/encodes.csv'
filepath = './data/decodes.json'
click = Click.new(filepath).hash_matches(filename)
puts click.to_json
