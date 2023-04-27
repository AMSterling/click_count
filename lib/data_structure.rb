require 'csv'
require 'json'

class DataStructure
  def initialize(data)
    @data = data
    @encodes = encodes
  end

  def encodes
    arr = []
    CSV.foreach(@data, headers: true, header_converters: :symbol, col_sep: ',') do |row|
      arr << row.to_hash
    end
    arr
  end
end
