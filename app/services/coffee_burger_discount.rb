module Services
  class CoffeeBurgerDiscount
    def process(order)
      order_total = 0.0
      order.order_items.includes(:item).each do |order_item|
        if order_item.item.description == 'coffee'
          order_total += (order_item.item.price*(0.9) * order_item.quantity).to_f
        elsif order_item.item.description == 'burger'
          order_total += (order_item.item.price*(0.85) * order_item.quantity).to_f
        else
          order_total += (order_item.item.price * order_item.quantity).to_f
        end
      end
      return order_total
    end
  end
end
