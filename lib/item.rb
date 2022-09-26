class Item

  attr_reader :name, :bids

  def initialize(name)
    @name = name
    @bids = {}
    @open_bidding = true
  end

  def add_bid(attendee, amount)
    @bids[attendee] = amount if @open_bidding == true
  end

  def current_high_bid
    bid_amounts = []
    @bids.each_pair do |attendee, bid|
      bid_amounts << bid
    end
    bid_amounts.max
  end

  def close_bidding
    @open_bidding = false
  end

end
