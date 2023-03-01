module Services
  class NoDiscount
    def process(order)
      order_total = 0.0
      order.order_items.includes(:item).each do |order_item|
        order_total += (order_item.item.price * order_item.quantity).to_f
      end
      return order_total
    end
  end
end
