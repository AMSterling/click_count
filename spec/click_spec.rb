require 'rspec'
require 'csv'
require 'json'
require './lib/data_structure'
require './lib/click'

RSpec.describe Click do
  let(:filename) { './data/encodes.csv' }
  let(:filepath) { './data/decodes.json' }
  let(:csv) { DataStructure.new(filename) }
  let(:dataset) { Click.new(filepath) }

  it 'reads the json' do

    expect(dataset).to be_a Click
    expect(dataset.decodes).to be_an Array
    expect(dataset.decodes.count).to eq 10000
    dataset.decodes.each do |set|
      expect(set.keys).to eq([:bitlink, :user_agent, :timestamp, :referrer, :remote_ip])
    end
  end

  it 'filters the file to return 2021 timestamps' do

    expect(dataset).to be_a Click
    expect(dataset.filter_by_date).to be_an Array
    expect(dataset.filter_by_date.count).to eq 5082
    dataset.filter_by_date.each do |set|
      expect(set.keys).to eq([:bitlink, :user_agent, :timestamp, :referrer, :remote_ip])
      expect(set[:timestamp]).to start_with('2021')
    end
  end

  it 'tallies bitlink urls' do

    expect(dataset.path_count).to be_a Hash
    expect(dataset.path_count).to eq({"3MgVNnZ"=>521,
                                      "2kjqil6"=>521,
                                      "2kkAHNs"=>512,
                                      "2kJdsg8"=>510,
                                      "2lNPjVU"=>557,
                                      "2kJO0qS"=>497,
                                      "2kJej0k"=>496,
                                      "3hxENM5"=>466,
                                      "31Tt55y"=>492,
                                      "3C5IIJm"=>510})
  end

  it 'matches csv hash with bitlink path' do

    expect(dataset.hash_matches(filename)).to be_an Array
    expect(dataset.hash_matches(filename)).to eq([{"https://youtube.com/"=>557},
                                                  {"https://twitter.com/"=>512},
                                                  {"https://reddit.com/"=>510},
                                                  {"https://github.com/"=>497},
                                                  {"https://linkedin.com/"=>496},
                                                  {"https://google.com/"=>492}])
  end
end
