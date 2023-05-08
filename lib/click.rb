require 'csv'
require 'json'
require 'date'
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
    decodes.select { |bitlink| bitlink[:timestamp][0..3] == @search_year }
  end

  def path_count
    filter_by_date.map { |link| link[:bitlink].split('/').last }.tally
  end

  def user_input
    input_year = $stdin.gets.chomp
      # unless input_year.match?(/^\d{4}$/)
      #   puts "Must be a 4-digit year (YYYY), run again"
      #   exit
      # end
  end

  def hash_matches(filename)
    data = DataStructure.new(filename).encodes
    puts 'Enter a year (YYYY)'
    @search_year = user_input
    result = data.map do |el|
      x = path_count.keep_if { |k, v| v if el[:hash] == k }.map(&:last)
      { "#{el[:long_url]}" =>  x[0] }
    end
    path_count.empty? ? "No results matching #{@search_year}" : result.sort_by! { |el| el.values }.reverse
  end
end
