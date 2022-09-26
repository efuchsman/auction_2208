class Auction

  attr_reader :items

  def initialize
    @items = []
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

end
