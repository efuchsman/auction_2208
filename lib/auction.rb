class Auction

  attr_reader :items, :bidders

  def initialize
    @items = []
    @bidders = []
  end

  def add_item(item)
  @items << item
  end

  def item_names
    @items.map(&:name)
  end

  def unpopular_items
    @items.select do |item|
      item.bids == {}
    end
  end

  def potential_revenue
    max_bid_array = []
    @items.each do |item|
      max_bid_array << item.current_high_bid if item.current_high_bid != nil
    end
    max_bid_array.sum
  end

  def bidders
    @items.each do |item|
      item.bids.each_pair do |attendee, amount|
      @bidders << attendee.name
      end
    end
    @bidders.uniq
  end

end
