require 'rspec'
require './lib/item'

RSpec.describe Item do
  it 'exists and has readable attributes' do
    item1 = Item.new('Chalkware Piggy Bank')

    expect(item1).to be_an_instance_of(Item)
    expect(item1.name).to eq("Chalkware Piggy Bank")
    expect(item1.bids).to eq({})
  end

end
