require 'spec_helper'
require './lib/encoded'
require './lib/decoded'

RSpec.describe Decoded do
  let(:filepath) { './data/decodes.json' }
  let(:json) { Decoded.new(filepath) }

  it 'reads the json' do

    expect(json).to be_a Decoded
    expect(json.decodes).to be_an Array
    expect(json.decodes.count).to eq 10000
    json.decodes.each do |set|
      expect(set.keys).to eq([:bitlink, :user_agent, :timestamp, :referrer, :remote_ip])
    end
  end
end
