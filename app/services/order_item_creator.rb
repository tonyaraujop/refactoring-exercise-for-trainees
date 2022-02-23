class OrderItemCreator < ApplicationService
  def initialize(cart, order)
    @cart = cart
    @order = order
  end

  def call
    create_order_items
  end

  private

  SHIPPING_COSTS = 100
  
  def create_order_items 
    @cart.items.each do |item|
      item.quantity.times do
        @order.items << OrderLineItem.new(
          order: @order,
          sale: item.sale,
          unit_price_cents: item.sale.unit_price_cents,
          shipping_costs_cents: SHIPPING_COSTS,
          paid_price_cents: item.sale.unit_price_cents + SHIPPING_COSTS
        )
      end
    end
    @order
  end
end
