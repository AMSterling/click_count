require 'json'

class Decoded
  def initialize(data)
    @data = data
    @decodes = decodes
  end

  def decodes
    json_file = File.read(@data)
    JSON.parse(json_file, symbolize_names: true)
  end
end
