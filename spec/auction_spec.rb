require 'rspec'
require './lib/item'
require './lib/attendee'
require './lib/auction'

RSpec.describe Auction do
  it 'exists and has a readable attribute for items' do
    auction = Auction.new

    expect(auction).to be_an_instance_of(Auction)
    expect(auction.items).to eq([])
  end
end
