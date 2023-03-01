module Services
  class ComputeOrderTotal

    def initialize(order)
      @order = order
      @item_list ||= Hash.new(0)
      @order_total = nil
    end

    def process(order = @order)
      if order_has_coffee_sandwich_and_pepsi?
        coffee_sandwich_pepsi_discount
      elsif order_has_coffee_and_burger?
        coffee_burger_discount
      elsif order_has_pepsi_and_burger?
        pepsi_burger_discount
      else
        no_discount_order
      end
      return @order_total
    end

    private

    def get_item_list
      return @item_list unless @item_list.empty?
      @order.order_items.includes(:item).each { |oi| @item_list[oi.item.description] = oi.quantity }
      return @item_list
    end

    def coffee_burger_discount
      return @order_total if @order_total
      @order_total = 0.0
      @order.order_items.includes(:item).each do |order_item|
        if order_item.item.description == 'coffee'
          @order_total += (order_item.item.price*(0.9) * order_item.quantity).to_f
        elsif order_item.item.description == 'burger'
          @order_total += (order_item.item.price*(0.85) * order_item.quantity).to_f
        else
          @order_total += (order_item.item.price * order_item.quantity).to_f
        end
      end
  
      @order.update_column(:order_total, @order_total)
    end

    def pepsi_burger_discount
      return @order_total if @order_total
      @order_total = 0.0
      @order.order_items.includes(:item).each do |order_item|
        if order_item.item.description == 'pepsi'
          @order_total += (order_item.item.price*(0.85) * order_item.quantity).to_f
        elsif order_item.item.description == 'burger'
          @order_total += (order_item.item.price*(0.85) * order_item.quantity).to_f
        else
          @order_total += (order_item.item.price * order_item.quantity).to_f
        end
      end
  
      @order.update_column(:order_total, @order_total)
    end

    def coffee_sandwich_pepsi_discount
      @order_total = 0.0
      @order.order_items.includes(:item).each do |order_item|
        if order_item.item.description == 'coffee'
          @order_total += (order_item.item.price*(0.9) * order_item.quantity).to_f
        elsif order_item.item.description == 'burger'
          @order_total += (order_item.item.price*(0.85) * order_item.quantity).to_f
        elsif order_item.item.description == 'pepsi'
          @order_total += (order_item.item.price*(0.9) * order_item.quantity).to_f
        else
          @order_total += (order_item.item.price * order_item.quantity).to_f
        end
      end
  
      @order.update_column(:order_total, @order_total)
    end

    def no_discount_order
      return @order_total if @order_total
      @order_total = 0.0
      @order.order_items.includes(:item).each do |order_item|
        @order_total += (order_item.item.price * order_item.quantity).to_f
      end
  
      @order.update_column(:order_total, @order_total)
    end

    def order_has_coffee_and_burger?
      return true if has_coffee? && has_burger?
      false
    end

    def order_has_pepsi_and_burger?
      return true if has_pepsi? && has_burger?
      false
    end

    def order_has_coffee_sandwich_and_pepsi?
      if has_coffee? && has_sandwich? && has_pepsi?
        return true
      end
      false
    end

    def has_coffee?
      return true if get_item_list['coffee'] > 0
      false
    end

    def has_burger?
      return true if get_item_list['burger'] > 0
      false
    end

    def has_pepsi?
      return true if get_item_list['pepsi'] > 0
      false
    end

    def has_sandwich?
      return true if get_item_list['sandwich'] > 0
      false
    end

  end
end
