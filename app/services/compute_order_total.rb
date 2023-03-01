module Services
  class ComputeOrderTotal

    def initialize(order)
      @order = order
      @item_list ||= Hash.new(0)
      @order_total = nil
    end

    def process(order = @order)
      @order_total =  if order_has_coffee_sandwich_and_pepsi?
                        Services::CoffeeSandwichPepsiDiscount.new.process(@order)
                      elsif order_has_coffee_and_burger?
                        Services::CoffeeBurgerDiscount.new.process(@order)
                      elsif order_has_pepsi_and_burger?
                        Services::PepsiBurgerDiscount.new.process(@order)
                      else
                        Services::NoDiscount.new.process(@order)
                      end
      update_order_total
      return @order_total
    end

    private

    def get_item_list
      return @item_list unless @item_list.empty?
      @order.order_items.includes(:item).each { |oi| @item_list[oi.item.description] = oi.quantity }
      return @item_list
    end

    def update_order_total
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
