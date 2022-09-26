require 'rspec'
require './lib/item'
require './lib/attendee'

RSpec.describe Attendee do
  it 'exists and has readable attributes' do
    attendee = Attendee.new({name: 'Megan', budget: '$50'})

    expect(attendee).to be_an_instance_of(Attendee)
    expect(attendee.name).to eq("Megan")
    expect(attendee.budget).to eq(50)
  end
end
