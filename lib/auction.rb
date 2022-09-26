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


  def bidder_info
    bidder_details_hash = Hash.new{|h, k| h[k] = { :budget => 0, :items => [] }  }

    @items.each do |item|
      item.bids.each_pair do |attendee, amount|
        bidder_details_hash[attendee][:budget] = attendee.budget
       if item.bids.keys.include?(attendee)
        bidder_details_hash[attendee][:items] << item
       end

      end
    end
     bidder_details_hash
  end

  def date
    Date.today.strftime("%d/%m/%Y")
  end

  def close_auction
    winners_hash = {}
    @items.each do |item|
      item.close_bidding
        if item.bids == {}
        winners_hash[item] = 'Not Sold'
        else
          item.bids.each_pair do |attendee, amount|
            winners_hash[item] = attendee if amount == item.current_high_bid
          end
        end
      end
    p winners_hash
  end


end
