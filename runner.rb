require './lib/encoded'
require './lib/decoded'
require './lib/click'

filename = './data/encodes.csv'
filepath = './data/decodes.json'
click = Click.new(filepath, filename).start
puts click
