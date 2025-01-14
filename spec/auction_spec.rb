require 'rspec'
require './lib/item'
require './lib/attendee'
require './lib/auction'
require 'date'

RSpec.describe Auction do
  it 'exists and has a readable attribute for items' do
    auction = Auction.new

    expect(auction).to be_an_instance_of(Auction)
    expect(auction.items).to eq([])
  end

  it 'can add items and list them by name' do
    auction = Auction.new
    item1 = Item.new('Chalkware Piggy Bank')
    item2 = Item.new('Bamboo Picture Frame')

    auction.add_item(item1)
    auction.add_item(item2)

    expect(auction.items).to eq([item1, item2])
    expect(auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
  end

  it "has items that can be bid on" do
    item1 = Item.new('Chalkware Piggy Bank')
    item2 = Item.new('Bamboo Picture Frame')
    item3 = Item.new('Homemade Chocolate Chip Cookies')
    item4 = Item.new('2 Days Dogsitting')
    item5 = Item.new('Forever Stamps')

    attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
    attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
    attendee3 = Attendee.new({name: 'Mike', budget: '$100'})

    auction = Auction.new

    auction.add_item(item1)
    auction.add_item(item2)
    auction.add_item(item3)
    auction.add_item(item4)
    auction.add_item(item5)

    expect(item1.bids).to eq({})

    item1.add_bid(attendee2, 20)
    item1.add_bid(attendee1, 22)

    expect(item1.bids).to eq(
      {
        attendee2 => 20,
        attendee1 => 22
        }
      )

      expect(item1.current_high_bid).to eq(22)
      item4.add_bid(attendee3, 50)

      expect(auction.unpopular_items).to eq([item2, item3, item5])

      item3.add_bid(attendee2, 15)
      expect(auction.unpopular_items).to eq([item2, item5])

      expect(auction.potential_revenue).to eq(87)

  end

  it 'can have an array of bidders' do
    item1 = Item.new('Chalkware Piggy Bank')
    item2 = Item.new('Bamboo Picture Frame')
    item3 = Item.new('Homemade Chocolate Chip Cookies')
    item4 = Item.new('2 Days Dogsitting')
    item5 = Item.new('Forever Stamps')

    attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
    attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
    attendee3 = Attendee.new({name: 'Mike', budget: '$100'})

    auction = Auction.new

    auction.add_item(item1)
    auction.add_item(item2)
    auction.add_item(item3)
    auction.add_item(item4)
    auction.add_item(item5)

    item1.add_bid(attendee1, 22)
    item1.add_bid(attendee2, 20)
    item4.add_bid(attendee3, 50)
    item3.add_bid(attendee2, 15)

    expect(auction.bidders).to eq(["Megan", "Bob", "Mike"])
    expect(item1.bids).to eq(
      {
        attendee1 => 22,
        attendee2 => 20

        }
      )

      item1.close_bidding
      item1.add_bid(attendee3, 70)

      expect(item1.bids).to eq(
        {
          attendee1 => 22,
          attendee2 => 20

          }
        )

  end

  it 'can list bidder info' do
    item1 = Item.new('Chalkware Piggy Bank')
    item2 = Item.new('Bamboo Picture Frame')
    item3 = Item.new('Homemade Chocolate Chip Cookies')
    item4 = Item.new('2 Days Dogsitting')
    item5 = Item.new('Forever Stamps')

    attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
    attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
    attendee3 = Attendee.new({name: 'Mike', budget: '$100'})

    auction = Auction.new

    auction.add_item(item1)
    auction.add_item(item2)
    auction.add_item(item3)
    auction.add_item(item4)
    auction.add_item(item5)

    item1.add_bid(attendee1, 22)
    item1.add_bid(attendee2, 20)
    item4.add_bid(attendee3, 50)
    item3.add_bid(attendee2, 15)

    expect(auction.bidders).to eq(["Megan", "Bob", "Mike"])
    expect(item1.bids).to eq(
      {
        attendee1 => 22,
        attendee2 => 20

        }
      )

      item1.close_bidding
      item1.add_bid(attendee3, 70)

      expect(item1.bids).to eq(
        {
          attendee1 => 22,
          attendee2 => 20

          }
        )

        expect(auction.bidder_info).to eq(
          {
            attendee1 =>
            {
              :budget => 50,
              :items => [item1]
            },
            attendee2 =>
            {
              :budget => 75,
              :items => [item1, item3]
            },

            attendee3 =>
            {
              :budget => 100,
              :items => [item4]

            }
              }
            )

  end

  it 'has has a date' do
    item1 = Item.new('Chalkware Piggy Bank')
    item2 = Item.new('Bamboo Picture Frame')
    item3 = Item.new('Homemade Chocolate Chip Cookies')
    item4 = Item.new('2 Days Dogsitting')
    item5 = Item.new('Forever Stamps')

    attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
    attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
    attendee3 = Attendee.new({name: 'Mike', budget: '$100'})

    auction = Auction.new

    auction.add_item(item1)
    auction.add_item(item2)
    auction.add_item(item3)
    auction.add_item(item4)
    auction.add_item(item5)

    allow(Date).to receive(:today).and_return(Date.new(2022, 9, 26))
    expect(auction.date).to eq('26/09/2022')
  end

  it 'can close' do
    item1 = Item.new('Chalkware Piggy Bank')
    item2 = Item.new('Bamboo Picture Frame')
    item3 = Item.new('Homemade Chocolate Chip Cookies')
    item4 = Item.new('2 Days Dogsitting')
    item5 = Item.new('Forever Stamps')

    attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
    attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
    attendee3 = Attendee.new({name: 'Mike', budget: '$100'})

    auction = Auction.new

    auction.add_item(item1)
    auction.add_item(item2)
    auction.add_item(item3)
    auction.add_item(item4)
    auction.add_item(item5)

    item1.add_bid(attendee1, 22)
    item1.add_bid(attendee2, 20)
    item4.add_bid(attendee2, 30)
    item4.add_bid(attendee3, 50)
    item3.add_bid(attendee2, 15)
    item5.add_bid(attendee1, 35)

    expect(auction.close_auction).to eq(
      {
        item1 => attendee1,
         item2 => 'Not Sold',
        item3 => attendee2,
        item4 => attendee3,
        item5 => attendee1
        }
      )
  end


end
