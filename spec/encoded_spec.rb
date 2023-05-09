require 'spec_helper'
require './lib/encoded'
require './lib/decoded'

RSpec.describe Encoded do
  let(:filename) { './data/encodes.csv' }
  let(:csv) { Encoded.new(filename) }

  it 'reads and coverts the CSV' do

    expect(csv).to be_a Encoded
    expect(csv.encodes).to be_an Array
    expect(csv.encodes.count).to eq 6
    csv.encodes.each do |struct|
      expect(struct.keys).to eq([:long_url, :domain, :hash])
      expect(struct[:long_url]).to include('https://')
      expect(struct[:domain]).to eq('bit.ly')
    end
  end
end
