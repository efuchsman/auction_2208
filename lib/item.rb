class Item

  attr_reader :name, :bids

  def initialize(name)
    @name = name
    @bids = {}
  end

  def add_bid(attendee, amount)
    @bids[attendee] = amount
  end

  def current_high_bid
    bid_amounts = []
    @bids.each_pair do |attendee, bid|
      bid_amounts << bid
    end
    bid_amounts.max
  end

end
