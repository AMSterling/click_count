require 'csv'
require 'json'
require './lib/data_structure'

class Click
  def initialize(data)
    @data = data
    @decodes = decodes
  end

  def decodes
    json_file = File.read(@data)
    JSON.parse(json_file, symbolize_names: true)
  end

  def filter_by_date
    decodes.select { |bitlink| bitlink[:timestamp][0..3] == '2021' }
  end

  def path_count
    filter_by_date.map { |link| link[:bitlink].split('/').last }.tally
  end

  def hash_matches(filename)
    data = DataStructure.new(filename).encodes
    result = data.map do |el|
      x = path_count.keep_if { |k, v| v if el[:hash] == k }.map(&:last)
      { "#{el[:long_url]}" =>  x[0] }
    end
    result.sort_by! { |el| el.values }.reverse
  end
end
# Can add .as_json
