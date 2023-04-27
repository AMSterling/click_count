require 'rspec'
require 'csv'
require 'json'
require './lib/data_structure'

RSpec.describe DataStructure do
  let(:filename) { './data/encodes.csv' }
  let(:csv) { DataStructure.new(filename) }

  it 'reads and coverts the CSV' do

    expect(csv).to be_a DataStructure
    expect(csv.encodes).to be_an Array
    expect(csv.encodes.count).to eq 6
    csv.encodes.each do |struct|
      expect(struct.keys).to eq([:long_url, :domain, :hash])
      expect(struct[:long_url]).to include('https://')
      expect(struct[:domain]).to eq('bit.ly')
    end
  end
end
