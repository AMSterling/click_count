require 'spec_helper'
require './lib/encoded'
require './lib/decoded'
require './lib/click'

RSpec.describe Click do
  let(:filename) { './data/encodes.csv' }
  let(:filepath) { './data/decodes.json' }
  let(:csv) { Encoded.new(filename) }
  let(:click) { Click.new(filepath, filename) }

  xit 'filters the file to return user entered timestamps' do
    allow($stdin).to receive(:gets).and_return('2021')

    expect(click).to be_a Click
    expect(click.user_input).to eq('2021')
    expect(click.filter_by_date).to be_an Array
    expect(click.filter_by_date.count).to eq 5082
    click.filter_by_date.each do |set|
      expect(set.keys).to eq([:bitlink, :user_agent, :timestamp, :referrer, :remote_ip])
      expect(set[:timestamp]).to start_with('2021')
    end
  end

  xit 'tallies bitlink urls' do
    allow($stdin).to receive(:gets).and_return('2021')

    expect(click.path_count).to be_a Hash
    expect(click.path_count).to eq({"3MgVNnZ"=>521,
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
  describe '#start' do
    it 'only allows 4 digit user input' do
      allow($stdin).to receive(:gets).and_return('201')

      expect(click.start)
      .to eq('Must be a 4-digit year (YYYY), try again')
    end

    it 'has no matches' do
      allow($stdin).to receive(:gets).and_return('2018')

      expect(click.start)
      .to eq('No results matching 2018')
    end

    it 'matches csv hash with bitlink path' do
      allow($stdin).to receive(:gets).and_return('2021')

      expect(click.start).to be_an Array
      expect(click.start).to eq(
        [
          {"https://youtube.com/"=>557},
          {"https://twitter.com/"=>512},
          {"https://reddit.com/"=>510},
          {"https://github.com/"=>497},
          {"https://linkedin.com/"=>496},
          {"https://google.com/"=>492}
        ]
       )
    end
  end
end
