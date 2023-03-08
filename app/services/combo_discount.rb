module Services
  class ComboDiscount
    def initialize(order, combo_discounts)
      @order = Order.includes(order_items: :item).find(order.id)
      @combo_discounts = combo_discounts
      @order_total = nil
    end

    def process(order = @order)
      @order_total = compute_order_total
      return @order_total
    end

    private

    def compute_order_total
      order_total = 0.0
      @order.order_items.each do |order_item|
        item_description = order_item.item.description
        if (@combo_discounts[item_description.to_sym])
          discount = (1-@combo_discounts[item_description.to_sym])
        else
          discount = 1
        end
        order_total += (order_item.item.price * discount * order_item.quantity).to_f
      end
      return order_total
    end
  end
end
