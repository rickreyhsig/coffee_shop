module Services
  class ComboDiscount
    def initialize(order, combo_discounts)
      @order = Order.includes(order_items: :item).find(order.id)
      @combo_discounts = combo_discounts
    end

    def process(order = @order)
      return compute_order_total
    end

    private

    def compute_order_total
      order_total = 0.0
      @order.order_items.each do |order_item|
        discount = item_discount(order_item)
        order_total += (order_item.item.price * discount * order_item.quantity).to_f
      end
      return order_total
    end

    def item_discount(order_item)
      item = order_item.item.description
      return @combo_discounts[item.to_sym] ? (1-@combo_discounts[item.to_sym]) : 1
    end
  end
end
