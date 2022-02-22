class OrderItemCreator < ApplicationService
  def initialize(cart, order, shipping_costs)
    @cart = cart
    @order = order
    @shipping_costs = shipping_costs
  end

  def call
    create_order_items
  end

  private

  def create_order_items 
    @cart.items.each do |item|
      item.quantity.times do
        @order.items << OrderLineItem.new(
          order: @order,
          sale: item.sale,
          unit_price_cents: item.sale.unit_price_cents,
          shipping_costs_cents: @shipping_costs,
          paid_price_cents: item.sale.unit_price_cents + @shipping_costs
        )
      end
    end
    @order.save
  end
end
