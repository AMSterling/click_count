require 'csv'
require 'json'
require 'stringio'
require './lib/encoded'
require './lib/decoded'

class Click
  def initialize(filepath, filename)
    @encodes = Encoded.new(filename).encodes
    @decodes = Decoded.new(filepath).decodes
  end

  def start
    puts 'Enter a year (YYYY)'
    @search_year = $stdin.gets.chomp
    @search_year.match?(/^\d{4}$/) ? hash_matches : 'Must be a 4-digit year (YYYY), try again'
  end

  def filter_by_date
    @decodes.select { |bitlink| bitlink[:timestamp][0..3] == @search_year }
  end

  def path_count
    filter_by_date.map { |link| link[:bitlink].split('/').last }.tally
  end

  def hash_matches
    result = @encodes.map do |el|
      x = path_count.keep_if { |k, v| v if el[:hash] == k }.map(&:last)
      { "#{el[:long_url]}" =>  x[0] }
    end
    path_count.empty? ? "No results matching #{@search_year}" : result.sort_by! { |el| el.values }.reverse
  end
end
